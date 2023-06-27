import 'package:flutter/material.dart';

import '../constant.dart';

class MyDropDown extends StatefulWidget {
  final String dropDownController;

  const MyDropDown({Key? key, required this.dropDownController}) : super(key: key);

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  String selectedValue = '';

  @override
  void initState() {
    super.initState();
    selectedValue = widget.dropDownController;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        width: size.width / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200, width: 4),
          color: Colors.grey.shade200,
        ),
        child: Column(
          children: [
            Container( // Wrap the DropdownButton with Expanded
              child: DropdownButton<String>(
                value: selectedValue,
                elevation: 16,
                style: TextStyle(color: Colors.grey[500]),
                underline: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  height: 2,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    selectedValue = value!;
                  });
                },
                items: skillsList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(color: Colors.grey[500])),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
