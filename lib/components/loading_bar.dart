import 'package:flutter/material.dart';

class LoadingDialogBox extends StatelessWidget {
  final String message;

  const LoadingDialogBox({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getCircleBar(),
          Text(message + "please wait"),
        ],
      ),
    );
  }

  _getCircleBar() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.deepOrange),
      ),
    );
  }
}
