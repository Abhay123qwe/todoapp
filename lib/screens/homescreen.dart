// ignore_for_file: avoid_unnecessary_containers

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:random_string/random_string.dart';
import 'package:todoapp/const/colors.dart';
import 'package:todoapp/db_services/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool personal = true, college = false, work = false;
  bool suggest = false;
  Stream? todoStream;
  getonTheLoad() async {
    todoStream = await DatabaseService().getTask(personal
        ? "Personal"
        : college
            ? "College"
            : "Office");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  Widget getWork() {
    return StreamBuilder(
        stream: todoStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot docSnap = snapshot.data.docs[index];
                        return CheckboxListTile(
                          activeColor: clgreen,
                          title: Text(
                            docSnap["work"],
                            style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: cwhite),
                          ),
                          value: docSnap["Yes"],
                          onChanged: (newvalue) async {
                            await DatabaseService().tickMethod(
                                docSnap["ID"],
                                personal
                                    ? "Personal"
                                    : college
                                        ? "College"
                                        : "Office");
                            setState(() {
                              Future.delayed(const Duration(seconds: 2), () {
                                DatabaseService().removeMethod(
                                    docSnap["ID"],
                                    personal
                                        ? "Personal"
                                        : college
                                            ? "College"
                                            : "Office");
                              });
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        );
                      }))
              : const Center(
                  child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    CircularProgressIndicator(
                      color: cred,
                    ),
                  ],
                ));
        });
  }

  TextEditingController todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: clgreen,
        onPressed: () {
          openBox();
        },
        child: const Icon(
          Icons.add,
          color: cwhite,
          size: 35,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 70, left: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.greenAccent,
          Colors.pinkAccent,
          Colors.orangeAccent,
          Colors.cyanAccent,
          Colors.orangeAccent,
          Colors.pinkAccent,
          Colors.greenAccent,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: const Text(
                "Hii,",
                style: TextStyle(fontSize: 30, color: cblack),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: const Text(
                "Abhay,",
                style: TextStyle(fontSize: 54, color: cblack),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: const Text(
                "Let's the work begins !",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                personal
                    ? Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: clgreen,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            "Personal",
                            style: TextStyle(
                                fontSize: 20,
                                color: cred,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          personal = true;
                          college = false;
                          work = false;
                          await getonTheLoad();
                          setState(() {});
                        },
                        child: const Text(
                          "Personal",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                college
                    ? Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: clgreen,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            "College",
                            style: TextStyle(
                                fontSize: 20,
                                color: cred,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          personal = false;
                          college = true;
                          work = false;
                          await getonTheLoad();
                          setState(() {});
                        },
                        child: const Text(
                          "College",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                work
                    ? Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                              color: clgreen,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            "Office",
                            style: TextStyle(
                                fontSize: 20,
                                color: cred,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          personal = false;
                          college = false;
                          work = true;
                          await getonTheLoad();
                          setState(() {});
                        },
                        child: const Text(
                          "Office",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            getWork()
          ],
        ),
      ),
    );
  }

  Future openBox() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.cancel),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          const Text(
                            "Add ToDo Task ~",
                            style: TextStyle(color: cred),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Add Text"),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: cblack, width: 2)),
                        child: TextField(
                          controller: todoController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter the task"),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: clgreen,
                              borderRadius: BorderRadius.circular(10)),
                          child: GestureDetector(
                            onTap: () {
                              String id = randomAlphaNumeric(10);
                              Map<String, dynamic> userToDo = {
                                "work": todoController.text,
                                "ID": id,
                                "Yes": false,
                              };
                              personal
                                  ? DatabaseService()
                                      .addPersonalTask(userToDo, id)
                                  : college
                                      ? DatabaseService()
                                          .addCollegeTask(userToDo, id)
                                      : DatabaseService()
                                          .addOfficeTask(userToDo, id);
                              Navigator.pop(context);
                            },
                            child: const Center(
                              child: Text(
                                "Add",
                                style: TextStyle(color: cblack),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
