// import 'package:flutter/material.dart';
// import 'package:programmers_network_app/core/const/color_const.dart';
// import 'package:programmers_network_app/core/const/font.dart';

// class Custombutton extends StatefulWidget {
//   final String text;
//   final VoidCallback? onTap;

//   const Custombutton({super.key, required this.text, this.onTap});

//   @override
//   State<Custombutton> createState() => _CustombuttonState();
// }

// class _CustombuttonState extends State<Custombutton> {
//   bool isPressed = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (_) {
//         setState(() {
//           isPressed = true;
//         });
//       },
//       onTapUp: (_) {
//         setState(() {
//           isPressed = false;
//         });
//         widget.onTap?.call();
//       },
//       onTapCancel: () {
//         setState(() {
//           isPressed = false;
//         });
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 120),
//         transform: Matrix4.translationValues(0, isPressed ? 4 : 0, 0),
//         child: Card(
//           shape: const CircleBorder(),
//           elevation: isPressed ? 5 : 20,
//           shadowColor: ColorConst.colorButton,
//           child: Container(
//             width: double.infinity,
//             height: 60,
//             decoration: BoxDecoration(
//               color: ColorConst.colorBackGroung,
//               borderRadius: BorderRadius.circular(90),
//             ),
//             child: Center(
//               child: Text(
//                 widget.text,
//                 style: const TextStyle(
//                   fontFamily: Font.font2,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
