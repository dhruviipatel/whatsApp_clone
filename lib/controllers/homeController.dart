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

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  String getConversationId(String id) =>
      ac.loginuser.value.hashCode <= id.hashCode
          ? '${ac.loginuser.value!.id}_$id'
          : '${id}_${ac.loginuser.value!.id}';

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      Chatuser chatuser) {
    print(chatuser);
    return firestore
        .collection('chats/${getConversationId(chatuser.id)}/messages/')
        .snapshots();
  }

  Future<void> sendMessage(Chatuser chatuser, String msg) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final message = Message(
        fromId: ac.loginuser.value!.id,
        msg: msg,
        read: '',
        sent: time,
        toId: chatuser.id,
        type: Type.text);
    final ref = firestore
        .collection('chats/${getConversationId(chatuser.id)}/messages/');
    await ref.doc(time).set(message.toJson());
  }

  getFormatedDate({required BuildContext context, required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }

  updateMessageRealStatus(Message message) {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    firestore
        .collection('chats/${getConversationId(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': time});
  }
}
