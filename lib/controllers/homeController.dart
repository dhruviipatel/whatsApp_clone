import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/authController.dart';
import 'package:whatsapp_clone/models/chatuserModel.dart';
import 'package:whatsapp_clone/models/messageModel.dart';

class HomeController extends GetxController {
  final ac = Get.put(AuthController());
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  var tabIndex = 0.obs;

  var obxvalue = false.obs;

  var iSe = false.obs;

  var chatText = ''.obs;

  var showEmoji = false.obs;

  RxString selectedChatImg = ''.obs;

  Rx<Message?> message = Rx<Message?>(null);

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  //get conversation id to get message between two users
  String getConversationId(String id) {
    print(id.hashCode);
    return ac.loginuser.value!.id.hashCode <= id.hashCode
        ? '${ac.loginuser.value!.id}_$id'
        : '${id}_${ac.loginuser.value!.id}';
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
  Future<void> sendChatImage(Chatuser chatuser, File file) async {
    final ext = file.path.split('.').last;

    final ref = firebaseStorage.ref().child(
        'images/${getConversationId(chatuser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('data transfered: ${p0.bytesTransferred / 1000} kb');
    });

    String imgUrl = await ref.getDownloadURL();

    await sendMessage(chatuser, imgUrl, Type.image);
  }
}
