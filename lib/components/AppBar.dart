import 'package:desafiocoimbra/styles/Colors.dart';
import 'package:flutter/material.dart';

AppBar appbar({String title}) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title), /*_stream()*/
      ],
    ),
    backgroundColor: primary,
  );
}
