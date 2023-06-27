import 'package:cafeee/Screens/guruDetailsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/guruListTile.dart';

class FinanceScreen extends StatefulWidget {
  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
            margin: EdgeInsets.only(top: 40),
            child: SingleChildScrollView(
              child: Container(
                height: size.height / 1.25,
                width: size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('Gurus').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    List<Widget> guruWidgets = [];
                    if (snapshot.hasData) {
                      final gurus = snapshot.data?.docs.reversed.toList();
                      for (var client in gurus!) {
                        if (client['isOnline'] == true) {
                          final clientWidget = GuruListTile(
                             data: client
                          );

                          guruWidgets.add(clientWidget);
                        }
                      }
                    }
                    return ListView(
                      children: guruWidgets,
                    );
                  },
                ),
              ),
            )),
      ),
    );
  }

  static String shortenName(String nameRaw,
      {int nameLimit = 10, bool addDots = true}) {
    //* Limiting val should not be gt input length (.substring range issue)
    final max = nameLimit < nameRaw.length ? nameLimit : nameRaw.length;
    //* Get short name
    final name = nameRaw.substring(0, max);
    //* Return with '..' if input string was sliced
    if (addDots && nameRaw.length > max) return name + '...';
    return name;
  }
}

