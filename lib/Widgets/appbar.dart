import 'package:flutter/material.dart';

PreferredSizeWidget CustomAppBar(
    String text, {
      List<Widget>? actions,
    }) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.white),
    backgroundColor: Colors.orange,
    title: Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    centerTitle: true,
    elevation: 2,
    actions: actions ?? [], // Use the provided actions or an empty list if null
  );
}