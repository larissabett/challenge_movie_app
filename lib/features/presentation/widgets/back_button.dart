import 'package:flutter/material.dart';

Widget backButton() {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    width: 30,
    height: 30,
    child: FloatingActionButton(
      mini: true,
      backgroundColor: Colors.black,
      onPressed: () {
        //TODO - back navigation
      },
      child: const Icon(
        Icons.arrow_back_ios_sharp,
        color: Colors.white,
        size: 24,
      ),
    ),
  );
}
