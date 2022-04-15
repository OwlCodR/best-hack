import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget customCard({required Widget child}) {
  return Card(
    margin: const EdgeInsets.all(30.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    elevation: 10,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: child,
    ),
  );
}
