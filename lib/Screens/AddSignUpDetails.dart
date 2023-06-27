import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Logic/Auth.dart';
import '../components/my_button.dart';
import '../components/my_dropdown.dart';
import '../components/my_textfield.dart';
import '../constant.dart';
import 'loginPage.dart';

class AddSignUpDetails extends StatefulWidget {
  final username;
  AddSignUpDetails({super.key, this.username});

  @override
  State<AddSignUpDetails> createState() => _AddSignUpDetailsState();
}



class _AddSignUpDetailsState extends State<AddSignUpDetails> {
  // text editing controllers
  final descController = TextEditingController();
  final experienceController = TextEditingController();
  final rateController = TextEditingController();
  String dropDownController = skillsList[0];

  addGURU(String username, String desc, String skill, String experience, String rate) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Map<String, dynamic> message = {
      "username": username,
      "desc":desc,
      "skill":skill,
      "experience":double.parse(experience),
      "rate":double.parse(rate),
      "isOnline":true,
      "stars":2.5,
    };

    try {
      await _firestore.collection("Gurus").add(message);
      print('Document added successfully!');
    } catch (e) {
      print('Error adding document: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: size.width / 2,
                    child: MyTextField(
                      controller: experienceController,
                      hintText: 'Experience(in years)',
                      obscureText: false,
                    ),
                  ),
                  Container(
                    width: size.width / 2,
                    child: MyTextField(
                      controller: rateController,
                      hintText: 'Price',
                      obscureText: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: descController,
                hintText: 'Description',
                obscureText: false,
              ),
              const SizedBox(height: 10),

              MyDropDown(dropDownController: dropDownController),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),
              // sign in button
              MyButton(
                  onTap: () {
                    if (descController.text.isNotEmpty &&
                        experienceController.text.isNotEmpty &&
                        rateController.text.isNotEmpty)
                    {

                      addGURU(widget.username,descController.text,dropDownController,experienceController.text,rateController.text);

                    } else {
                      print("Please enter Fields");
                    }
                  },
                  text: "Sign Up"),
            ],
          ),
        ),
      ),
    );
  }
}
