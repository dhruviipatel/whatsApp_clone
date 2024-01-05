import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/controllers/authController.dart';
import 'package:whatsapp_clone/models/chatuserModel.dart';
import 'package:whatsapp_clone/models/groupMessageModel.dart';
import 'package:whatsapp_clone/models/groupModel.dart';
import 'package:whatsapp_clone/models/messageModel.dart';
import 'package:whatsapp_clone/screens/home/home_screen.dart';

class HomeController extends GetxController {
  final ac = Get.put(AuthController());
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  var stopNotification = false.obs;

  var tabIndex = 0.obs;

  var obxvalue = false.obs;

  var chatText = ''.obs;

  var showEmoji = false.obs;

  var isUploading = false.obs;

  RxString selectedChatImg = ''.obs;

  Rx<Message?> message = Rx<Message?>(null);

  RxList contactList = [].obs;

  RxString groupImage = ''.obs;

  //group chat data
  List<Chatuser> selectedMemberList = <Chatuser>[].obs;
  RxList finalMemberList = [].obs;

  RxBool isGroupChat = false.obs;

  //for tabbar change
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  //get conversation id to get message between two users
  getConversationId(String id) {
    print(id.hashCode);
    if (ac.loginuser.value != null) {
      return ac.loginuser.value!.id.hashCode <= id.hashCode
          ? '${ac.loginuser.value!.id}_$id'
          : '${id}_${ac.loginuser.value!.id}';
    }
    return null;
  }

  //get all message between two users
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      Chatuser chatuser) {
    print(chatuser);
    print(getConversationId(chatuser.id));
    return firestore
        .collection('chats/${getConversationId(chatuser.id)}/messages/')
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getGroupMessages(Group group) {
    return firestore
        .collection('groups/${group.groupId}/messages/')
        .snapshots();
  }

  //save first message data in data base
  saveFirstMessageData(Chatuser oppuser) async {
    await firestore
        .collection('users/${ac.loginuser.value?.id}/my_chat_users')
        .doc(oppuser.id)
        .set(oppuser.toJson());
    await firestore
        .collection('users/${oppuser.id}/my_chat_users')
        .doc(ac.loginuser.value?.id)
        .set(ac.loginuser.value!.toJson());
    return true;
  }

  //send message
  Future<void> sendMessage(Chatuser chatuser, String msg, Type type) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final message = Message(
        fromId: ac.loginuser.value!.id,
        msg: msg,
        read: '',
        sent: time,
        toId: chatuser.id,
        type: type);
    final ref = firestore
        .collection('chats/${getConversationId(chatuser.id)}/messages/');
    await ref.doc(time).set(message.toJson());
  }

  //get formatted date in chat screen
  getFormatedDate({required BuildContext context, required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }

  //when user seen message it update its read status
  updateMessageReadStatus(Message message) {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    firestore
        .collection('chats/${getConversationId(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': time});
  }

  //get last message to display it on homepage chat card
  Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(Chatuser user) {
    return firestore
        .collection('chats/${getConversationId(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  //get formatted date to display last message date for homepage chat card
  getLastMessageDate({required BuildContext context, required String time}) {
    final sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final now = DateTime.now();

    if (sent.day == now.day &&
        sent.month == now.month &&
        sent.year == now.year) {
      return TimeOfDay.fromDateTime(sent).format(context);
    }
    return '${sent.day}/${sent.month}/${sent.year}';
  }

  //send image in chat
  Future<String> sendChatImage(Chatuser chatuser, File file) async {
    final ext = file.path.split('.').last;

    final ref = firebaseStorage.ref().child(
        'images/${getConversationId(chatuser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('data transfered: ${p0.bytesTransferred / 1000} kb');
    });

    return await ref.getDownloadURL();
  }

  Future<String> sendGroupChatImage(Group group, File file) async {
    final ext = file.path.split('.').last;

    final ref = firebaseStorage.ref().child(
        'group_images/${group.groupId}}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('data transfered: ${p0.bytesTransferred / 1000} kb');
    });

    return await ref.getDownloadURL();
  }

  //choose multiple images
  chooseMultipleImages(chatuser) async {
    var images = await ImagePicker().pickMultiImage(imageQuality: 70);

    if (images.isEmpty) {
      return;
    }
    for (var i in images) {
      isUploading.value = true;
      await sendChatImage(chatuser, File(i.path));
      isUploading.value = false;
    }
  }

  //choose image from camera
  chooseImageFromCamera(chatuser) async {
    var img = await ImagePicker().pickImage(source: ImageSource.camera);
    if (img == null) {
      return;
    }
    return img.path;
  }

  //get specific user data to get its data
  Stream<QuerySnapshot<Map<String, dynamic>>> getSpecificUser(
      Chatuser chatuser) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: chatuser.id)
        .snapshots();
  }

  //update last active status
  updateOnlineStatus(isOnline) {
    print(isOnline);

    return firestore.collection('users').doc(ac.loginuser.value?.id).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString()
    });
  }

  //get last seen in format
  getFormattedLastSeen(
      {required BuildContext context, required String lastActive}) {
    final int i = int.tryParse(lastActive) ?? -1;

    if (i == -1) return 'Last seen not available';

    final time = DateTime.fromMillisecondsSinceEpoch(i);
    String formattedTime = TimeOfDay.fromDateTime(time).format(context);

    final now = DateTime.now();

    if (time.day == now.day &&
        time.month == now.month &&
        time.year == now.year) {
      return 'Last seen today at $formattedTime';
    }

    if ((now.difference(time).inHours / 24).round() == 1) {
      return 'Last seen yeasterday at $formattedTime';
    }

    String month = getMonth(time);
    return 'Last seen on ${time.day} $month on $formattedTime';
  }

  getMonth(DateTime date) {
    switch (date.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
    }
    return 'NA';
  }

  getJoiningDate({required BuildContext context, required String date}) {
    final int i = int.tryParse(date) ?? -1;

    if (i == -1) return 'Joining date not available';
    final joinedDate = DateTime.fromMillisecondsSinceEpoch(i);

    final now = DateTime.now();
    if (joinedDate.day == now.day) {
      return 'Today';
    }
    if ((now.difference(joinedDate).inHours / 24).round() == 1) {
      return 'Yeasterday';
    }
    if (joinedDate.month == now.month || joinedDate.year == now.year) {
      return '${getMonth(joinedDate)} ${joinedDate.day}';
    }
    return '${joinedDate.month} ${joinedDate.day}, ${joinedDate.year}';
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getHomeChatUsers() {
    final data = firestore
        .collection('users/${ac.loginuser.value?.id}/my_chat_users')
        .snapshots();

    return data;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllChatUsers() {
    final data = firestore
        .collection('users')
        .where('id', isNotEqualTo: ac.loginuser.value?.id)
        .snapshots();

    return data;
  }

  deleteHomeChatUsers(user) async {
    DocumentReference docRef = firestore
        .collection('users')
        .doc('${ac.loginuser.value?.id}/my_chat_users/${user.id}');
    docRef.delete();
  }

  //-------------------------------------------group chat functions--------------------------------------------------

  //members selection for create group
  addRemoveMember(index) {
    if (selectedMemberList.any((element) => element.id == index.id)) {
      selectedMemberList.removeWhere((element) => element.id == index.id);
    } else {
      selectedMemberList.add(index);
    }
    print(index);
  }

  List<Map<String, dynamic>> convertChatusersToMapList(
      List<Chatuser> chatusers) {
    List<Map<String, dynamic>> chatuserMapList = [];

    for (Chatuser chatuser in chatusers) {
      Map<String, dynamic> chatuserMap = {
        'is_online': chatuser.isOnline,
        'id': chatuser.id,
        'created_at': chatuser.createdAt,
        'push_token': chatuser.pushToken,
        'image': chatuser.image,
        'phone': chatuser.phone,
        'about': chatuser.about,
        'last_active': chatuser.lastActive,
        'name': chatuser.name,
      };

      chatuserMapList.add(chatuserMap);
    }

    return chatuserMapList;
  }

  //create new group
  createGroup(List<Chatuser> chatusers, groupName, File file) async {
    try {
      String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
      List<Map<String, dynamic>> chatuserMapList =
          convertChatusersToMapList(chatusers);
      String groupId = '${groupName}' + currentTime;
      await ac
          .storeFileToStorage('gropup_Profile_Images/${groupId}', file)
          .then((val) {
        List<String> adminlist = [];
        adminlist.add(ac.loginuser.value!.id);

        firestore.collection('groups').doc(groupId).set({
          'groupId': groupId,
          'groupName': groupName,
          'groupImage': val,
          'members': chatuserMapList,
          'admins': adminlist
        });

        print("Group created successfully");

        Get.offAll(() => HomeScreen());
        selectedMemberList.clear();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  //get single group
  Stream<QuerySnapshot<Map<String, dynamic>>> getSpecificGroup(Group group) {
    return firestore
        .collection('groups')
        .where('groupId', isEqualTo: group.groupId)
        .snapshots();
  }

  Future<void> sendGroupMessage(Group group, String msg, MType type) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final groupmsg = GroupMessage(
        fromId: ac.loginuser.value!.id,
        msg: msg,
        sent: time,
        groupId: group.groupId,
        type: type);

    final ref = firestore.collection('groups/${group.groupId}/messages/');
    await ref.doc(time).set(groupmsg.toJson());
  }
}
