import 'package:flutter/material.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

void showSnackbar({
  required String title,
  required String message,
  bool isError = false,

  bool isWarning = false,
}) {
  Get.snackbar(
    title,
    message,
    // backgroundColor: isError
    //     ? const Color.fromARGB(255, 221, 107, 107)
    //     : isWarning
    //     ? const Color.fromARGB(255, 227, 171, 115)
    //     : const Color.fromARGB(255, 133, 213, 137),
    colorText: Colors.black,
    icon: Icon(
      isError
          ? Icons.error_outline
          : isWarning
          ? Icons.warning_amber_rounded
          : Icons.check_circle_outline,
      color: Colors.red[200],
    ),
    snackPosition: SnackPosition.TOP,
    duration: const Duration(seconds: 4),
  );
}
