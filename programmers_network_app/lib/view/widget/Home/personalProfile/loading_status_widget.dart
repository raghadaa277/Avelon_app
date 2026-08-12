import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: ColorConst.colorApp),
    );
  }
}
