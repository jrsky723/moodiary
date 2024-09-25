import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showFirebaseErrorSnack(
  BuildContext context,
  Object? error,
) {
  String errorMessage;

  if (error is FirebaseException) {
    // FirebaseException인 경우
    errorMessage = error.message ?? "Something went wrong.";
  } else {
    // FirebaseException이 아닌 경우
    errorMessage = error.toString();
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      showCloseIcon: true,
    ),
  );
}
