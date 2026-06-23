import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';

import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/core/const/font.dart';
import 'package:programmers_network_app/core/const/routesPage.dart';

import 'package:programmers_network_app/view/widget/Home/card_ready_widget.dart';
import 'package:programmers_network_app/view/widget/auth/button_customer.dart';

class ReadyPage extends StatefulWidget {
  const ReadyPage({super.key});
  @override
  State<ReadyPage> createState() => _ReadyPageState();
}

class _ReadyPageState extends State<ReadyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.colorBackGroung,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 50),
                Text(
                  "Your developer journy",
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: Font.font2,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 20),

                Text(
                  "Starts now ... ",
                  style: TextStyle(
                    fontSize: 23,
                    fontFamily: Font.font2,
                    fontWeight: FontWeight.w800,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  textAlign: TextAlign.center,
                  "You 've successfully completed your setup.\nconnect with developers ,showcase your work,\ndescover opportunities and build amazing things.",
                  style: TextStyle(fontSize: 15, color: Color(0xFF9CA3AF)),
                ),
                SizedBox(height: 30),
                CardReadyWidget(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "،،",
                      style: TextStyle(
                        color: ColorConst.colorApp,
                        fontSize: 50,
                        height: 0.8,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        "Every great developer started\n with a single commit.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      ",,",
                      style: TextStyle(
                        color: ColorConst.colorApp,
                        fontSize: 50,
                        height: 0.8,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: ButtonCustomer(
                    text: "Enter Avelon",
                    onTap: () {
                      Get.offAllNamed(AppRoute.profilePage);
                    },
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "You 're all set. See you inside .💚 ",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: Font.font2,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
