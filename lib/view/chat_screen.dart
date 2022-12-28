import 'package:chat_getx/controller/chat_controller.dart';
import 'package:chat_getx/controller/home_controller.dart';
import 'package:chat_getx/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  var controller = Get.put<ChatController>(ChatController());

  @override
  Widget build(BuildContext context) {
    final Size s = MediaQuery.of(context).size;

    // Get.put<ChatController>(()=>Chat);
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.find<HomeController>().todos[0].name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: s.height / 1.25,
              width: s.width,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(
                          'chats/${controller.getGroupId.toString()}/message')
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (c, snap) {
                    return snap.hasData
                        ? ListView.builder(
                            reverse: true,
                            itemCount: snap.data!.docs.length,
                            itemBuilder: (context, index) {
                              return messages(
                                  s,
                                  snap.data!.docs[index]['message'],
                                  snap.data!.docs[index]['sentTo'],
                                  snap.data!.docs[index]['sentBy']);
                            })
                        : CircularProgressIndicator();
                  }),
            ),
            Container(
              height: s.height / 10,
              width: s.width,
              alignment: Alignment.center,
              child: SizedBox(
                height: s.height / 12,
                width: s.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: s.height / 17,
                      width: s.width / 1.3,
                      child: TextField(
                        controller: Get.find<ChatController>().message,
                        decoration: InputDecoration(
                            hintText: 'Send Message',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.find<ChatController>().sendMessage();
                      },
                      icon: const Icon(Icons.send_outlined),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messages(Size s, String message, sentBy, sentTo) {
    return Container(
      width: s.width,
      alignment: sentBy == FirebaseAuth.instance.currentUser!.uid
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: Text(
          message,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
