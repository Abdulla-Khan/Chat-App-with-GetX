// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String name;
  late String uid;
  late String email;
  UserModel({
    required this.name,
    required this.uid,
    required this.email,
  });

  UserModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    name = documentSnapshot['name'];
    email = documentSnapshot['email'];
    uid  = documentSnapshot['uid'];
  }
}
