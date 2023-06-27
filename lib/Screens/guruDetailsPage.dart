import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/rectangular_button.dart';
import '../components/rectangular_desc_field.dart';

class guruDetailsPage extends StatefulWidget {
  final guru;
  const guruDetailsPage({super.key, required this.guru});

  @override
  State<guruDetailsPage> createState() => _guruDetailsPageState();
}

class _guruDetailsPageState extends State<guruDetailsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  addProblem(String problem_description) async {
    print(widget.guru['username']);
    Map<String, dynamic> message = {
      "username": _auth.currentUser!.displayName!,
      "problem_description": problem_description,
      "time": FieldValue.serverTimestamp(),
    };

    // Check if the document for the current user exists
    _firestore
        .collection('problemsList')
        .doc(widget.guru['username'])
        .get()
        .then((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        // Update the existing document
        _firestore
            .collection('problemsList')
            .doc(widget.guru['username'])
            .update(message)
            .then((_) {
          print('Data updated for user: ${widget.guru['username']}');
        }).catchError((error) {
          print('Error updating data: $error');
        });
      } else {
        // Create a new document for the user
        _firestore
            .collection('problemsList')
            .doc(widget.guru['username'])
            .set(message)
            .then((_) {
          print('Document created for user: ${widget.guru['username']}');
        }).catchError((error) {
          print('Error creating document: $error');
        });
      }
    }).catchError((error) {
      print('Error retrieving document: $error');
    });
  }

  void addDataToFirestore(String problem_description) async {
    if(problem_description != ''){
    CollectionReference parentCollection =
    _firestore.collection('problemsList');

    CollectionReference subcollectionRef =
        parentCollection.doc('docs').collection(widget.guru['username']);
    DocumentReference documentRef = subcollectionRef.doc();

    Map<String, dynamic> message = {
      "username": _auth.currentUser!.displayName!,
      "problem_description": problem_description,
      "time": FieldValue.serverTimestamp(),
    };

    documentRef.set(message).then((_) {
      print('Data added to subcollection for user: ${widget.guru['username']}');
    }).catchError((error) {
      print('Error adding data to subcollection: $error');
    });
  }}

  @override
  Widget build(BuildContext context) {
    TextEditingController descController = TextEditingController();
    var testStyle = TextStyle(
        fontWeight: FontWeight.w500, fontSize: 18, color: Colors.grey[800]);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[300],
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey[300],
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade500,
                            offset: const Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0),
                        const BoxShadow(
                            color: Colors.white,
                            offset: Offset(-4.0, -4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0),
                      ]),
                  child: Center(
                      child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.account_circle,
                                  size: 100, color: Colors.red),
                              const SizedBox(
                                width: 16,
                              ),
                              Wrap(
                                direction: Axis.vertical,
                                spacing: 5,
                                children: [
                                  Text(
                                    "Name: ${widget.guru['username']}",
                                    style: testStyle,
                                  ),
                                  Text(
                                    "Rating:  ${widget.guru['stars']} star",
                                    style: testStyle,
                                  ),
                                  Text(
                                    "Exp:  ${widget.guru['experience']}+ hours",
                                    style: testStyle,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 24.0),
                            child: Text(
                                "₹" + widget.guru['rate'].toString() + "/hour",
                                style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Open Sans',
                                )),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${widget.guru['desc']}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.black54),
                      )
                    ],
                  )),
                ),
                SizedBox(
                  height: 20,
                ),
                RectangularDescField(
                  controller: descController,
                  hintText: 'The problem you want to discuss...',
                  obscureText: false,
                ),
                SizedBox(
                  height: 10,
                ),
                RectangularButton(
                  text: 'Connect',
                  press: () {
                    addDataToFirestore(descController.text);
                    descController.clear();
                  },
                  fontSize: 20,
                  // width: double.infinity,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
