import 'package:cafeee/Screens/guruDetailsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class GuruListTile extends StatefulWidget {
  final data;
  const GuruListTile(
      {Key? key,
        required this.data})
      : super(key: key);

  @override
  State<GuruListTile> createState() => _GuruListTileState();
}

class _GuruListTileState extends State<GuruListTile> {
  @override
  Widget build(BuildContext context) {
    var decoration =
    BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [
      BoxShadow(
        color: Colors.grey[300]!,
        offset: const Offset(4, 4),
        blurRadius: 15,
        spreadRadius: 1,
      ),
      BoxShadow(
        color: Colors.white,
        offset: const Offset(-4, -4),
        blurRadius: 15,
        spreadRadius: 1,
      ),
    ]);
    var testStyle = TextStyle(
        fontWeight: FontWeight.w500, fontSize: 15, color: Colors.grey[800]);
    String name = widget.data['username'];
    String desc = widget.data['desc'];
    String field = widget.data['skill'];
    double rating = widget.data['stars'];
    int exp = widget.data['experience'];
    return InkWell(
      child: Container(
        decoration: decoration,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        child: Icon(Icons.account_circle,
                            size: 50, color: Colors.red),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Wrap(
                        direction: Axis.vertical,
                        spacing: 5,
                        children: [
                          Text(
                            "Name: $name",
                            style: testStyle,
                          ),
                          Text(
                            "Rating:  ${rating} star",
                            style: testStyle,
                          ),
                          Text(
                            "Exp:  ${exp}K+ hours",
                            style: testStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text("${field}",
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Open Sans',
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Text(
                  "${desc}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.black54),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => guruDetailsPage(guru: widget.data)));
      },
    );
  }
}
