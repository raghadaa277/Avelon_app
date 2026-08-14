import 'package:flutter/material.dart';

class OverviewLoadingWidget extends StatelessWidget {
  const OverviewLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(50),
        child: CircularProgressIndicator(
          color: Color.fromARGB(255, 206, 241, 130),
        ),
      ),
    );
  }
}
