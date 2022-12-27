import 'package:chat_getx/view/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();

  TextEditingController password = TextEditingController();

  void login() {
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .whenComplete(() async {
        await FirebaseFirestore.instance.collection('users').add({
          'name': name.text,
          'email': email.text,
          'password': password.text,
          'uid': FirebaseAuth.instance.currentUser!.uid,
        }).whenComplete(() {
          Get.offAll(() => HomeView());
        });
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar('e', '');
    }
  }
}
