import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// google font  Ubuntu
class UbuntuTextStyle extends StatelessWidget {
  final String textData;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color, backgroundColor;
  final FontStyle fontStyle;
  final int maxLines;
  final TextAlign textAlign;

  const UbuntuTextStyle(
      {Key? key,
      required this.textData,
      required this.fontSize,
      this.fontStyle = FontStyle.normal,
      required this.maxLines,
      required this.textAlign,
      this.fontWeight = FontWeight.normal,
      required this.color,
      this.backgroundColor = Colors.transparent})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      textData,
      style: GoogleFonts.ubuntu(
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          fontStyle: fontStyle,
          backgroundColor: backgroundColor,
        ),
      ),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
