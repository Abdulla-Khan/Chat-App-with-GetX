import 'package:chat_getx/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Rx<List<MessageModel>> messageList = Rx<List<MessageModel>>([]);
  List<MessageModel> get messages => messageList.value;
  TextEditingController message = TextEditingController();
  var a = Get.arguments;
  var user = FirebaseAuth.instance.currentUser!.uid;

  String getGroupId() =>
      user.hashCode <= a[0].hashCode ? "${user}_${a[0]}" : "${a[0]}_$user";

  sendMessage() {
    firestore.collection('chats/${getGroupId().toString()}/message').add({
      'message': message.text,
      'time': FieldValue.serverTimestamp(),
      'sentBy': user,
      'sentTo': a[0],
    }).whenComplete(() {
      firestore
          .collection('chats')
          .doc(a[0])
          .collection('messaged')
          .doc(user)
          .set({
        'messageBy': user,
        'messageTo': a[0],
        'senderName': a[1],
        'lastMessage': message.text.trim()
      });
    });
  }

  Stream<List<MessageModel>> messageStream() {
    return firestore
        .collection('chats/${getGroupId.toString()}/message')
        .orderBy('time', descending: true)
        .snapshots()
        .distinct()
        .map((QuerySnapshot event) {
      for (var mess in event.docs) {
        final messageModel = MessageModel.fromDocumentSnapshot(mess);
        messages.add(messageModel);
      }

      return messages;
    });
  }
}
