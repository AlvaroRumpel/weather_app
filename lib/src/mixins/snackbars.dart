import 'package:flutter/material.dart';

mixin CustomSnackBar<T extends StatefulWidget> on State<T> {
  Future<void> showSnackBar(String message) async {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).colorScheme.error,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
          clipBehavior: Clip.none,
        ),
      );
    }
  }
}
