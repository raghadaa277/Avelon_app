import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/const/routesPage.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/view/screen/Home/home_page.dart';
import 'package:programmers_network_app/view/screen/Home/ready_page.dart';
import 'package:programmers_network_app/view/screen/Home/source_page.dart';
import 'package:programmers_network_app/view/screen/auth/complete_page.dart';
import 'package:programmers_network_app/view/screen/auth/forget_page.dart';
import 'package:programmers_network_app/view/screen/auth/register_page.dart';
import 'package:programmers_network_app/view/screen/auth/verify_page.dart';
import 'package:programmers_network_app/view/screen/profile/profile_page.dart';
import 'package:programmers_network_app/view/screen/profile/user_activity/user_activity_page.dart';
import 'package:programmers_network_app/view/screen/profile/user_status_history/user_status_history_page.dart';
import 'package:programmers_network_app/view/widget/welcome_widget.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoute.register: (context) => RegisterPage(),
  AppRoute.verify: (contex) => VerifyPage(),
  AppRoute.complete: (context) => CompletePage(),
  AppRoute.resetpassword: (context) => ForgetPasswordPage(),
  AppRoute.homePage: (context) =>
      HomePage(),
  AppRoute.source: (context) => SourcePage(),
  AppRoute.profilePage: (context) => ProfilePage(),
  AppRoute.readyPage: (context) => ReadyPage(),
  AppRoute.welcomePage: (context) => const WelcomeWidget(),
  AppRoute.userSession: (context) => UserActivityScreen(),
  AppRoute.userStatus: (context) => UserStatusHistoryScreen(),
};
