import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SearchLoadingWidget extends StatelessWidget {
  const SearchLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animation/search_empty.json',
        width: 200,
        height: 200,
      ),
    );
  }
}
