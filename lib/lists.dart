import 'package:flutter/material.dart';
Widget LL(String img, String country,String code) => Row(
  children: [
    SizedBox(
        height:20,
        width: 20,
        child: Image.asset(img)
    ),
    SizedBox(width: 10,),
    Text(country),
    SizedBox(width: 10,),
    Text((code)),
  ],
);
List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child:LL('assets/images/IND.jpg','IND',"+91"),value: "IND"),
    DropdownMenuItem(child:LL('assets/images/USA.png','USA',"+1"),value: "USA"),
  ];
  return menuItems;
}