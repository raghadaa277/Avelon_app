import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.colorBackGroung,
      body: Center(child: Text("Profile page", style: TextStyle(fontSize: 20))),
    );
  }
}
