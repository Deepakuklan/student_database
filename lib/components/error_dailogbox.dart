import 'package:flutter/material.dart';
import 'package:student_database/components/app_button.dart';

class ErrorDialogBox extends StatelessWidget {
  final String message;

  const ErrorDialogBox({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
      actions: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Center(
              child: AppButton(
                  text: "Ok",
                  borderRadius: 5,
                  bgColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  onTap: () => Navigator.pop(context))),
        ),
      ],
    );
  }
}
