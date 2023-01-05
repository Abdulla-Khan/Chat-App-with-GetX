import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_screen.dart';

class ChatTile extends StatelessWidget {
  ChatTile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(
                  'chats/${FirebaseAuth.instance.currentUser!.uid}/messaged')
              .snapshots()
              .distinct(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => ChatScreen(), arguments: [
                            snapshot.data!.docs[index]['messageBy'],
                            snapshot.data!.docs[index]['senderName'],
                          ]);
                        },
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.only(left: 10, right: 10),
                          leading: const CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 30,
                          ),
                          title: Text(
                            snapshot.data!.docs[index]['senderName'],
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          subtitle: SizedBox(
                            height: 20,
                            child: Text(
                              snapshot.data!.docs[index]['lastMessage'],
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),
                        ),
                      );
                    })
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}
