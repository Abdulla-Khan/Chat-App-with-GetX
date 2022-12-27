import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  late String message;
  late String sentTo;
  late String sentBy;
  late String time;
  MessageModel({
    required this.message,
    required this.sentTo,
    required this.sentBy,
    required this.time,
  });
  MessageModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    message = documentSnapshot['message'];
    sentTo = documentSnapshot['sentTo'];
    sentBy = documentSnapshot['sentBy'];
    // time = documentSnapshot['time'];
  }
}
