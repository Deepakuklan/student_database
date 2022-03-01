// import 'package:flutter/material.dart';

// class AppTextFormField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText, errorText;
//   final String helpText;
//   final Widget? prefixIcon, suffixIcon;
//   final bool isPassword;
//   final bool enabled;
//   final bool readOnly;
//   final Color borderColor;
//   final InputBorder border, enabledBorder, focusedBorder;
//   final TextStyle hintStyle, labelStyle;
//   final Color fillColor;

//   final Function(String)? onChanged;

//   AppTextFormField({
//     Key? key,
//     this.fillColor = Colors.transparent,
//     this.onChanged,
//     this.errorText = "",
//     this.hintStyle = const TextStyle(),
//     this.labelStyle = const TextStyle(),
//     required this.controller,
//     this.hintText = "",
//     this.helpText = "",
//     this.prefixIcon,
//     this.suffixIcon,
//     this.isPassword = false,
//     this.enabled = true,
//     this.readOnly = false,
//     this.borderColor = Colors.green,
//     this.border = const OutlineInputBorder(
//       borderSide: BorderSide(
//         color: Colors.green,
//         width: 1.0,
//       ),
//     ),
//     this.enabledBorder = const OutlineInputBorder(
//       borderSide: BorderSide(
//         color: Colors.green,
//         width: 1.0,
//       ),
//     ),
//     this.focusedBorder = OutlineInputBorder(
//       borderSide: const BorderSide(color: Colors.black, width: 2.0),
//       borderRadius: BorderRadius.circular(25.0),
//     ),
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       onChanged: onChanged,
//       controller: controller,
//       readOnly: readOnly,
//       obscureText: isPassword,
//       decoration: InputDecoration(
//         fillColor: fillColor,
//         focusedBorder: focusedBorder,
//         enabledBorder: enabledBorder,
//         errorText: errorText,
//         border: border,
//         hintText: hintText,
//         helperText: helpText,
//         prefixIcon: prefixIcon,
//         suffix: suffixIcon,
//         enabled: enabled,
//         hintStyle: hintStyle,
//         labelStyle: labelStyle,
//       ),
//     );
//   }
// }
