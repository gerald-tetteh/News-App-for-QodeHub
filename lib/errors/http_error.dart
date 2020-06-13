/*
Author: Gerald Addo-Tetteh
Name: News App

This file is used to display errors in 
retrieving data from server
*/

//imports
import 'package:flutter/material.dart';

//class which is used to create custom exceptions
class HttpError implements Exception {
  final String message;
  HttpError(this.message);

  @override
  String toString() {
    return message;
  }
}

// this widgets displays a custom error message
// on the appropriate screen
class ErrorWidget extends StatelessWidget {
  final String message;
  ErrorWidget(this.message);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 35,
          ),
          Text(
            message,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
