import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/core/const/routesPage.dart';
import 'package:programmers_network_app/view/screen/Home/home_page.dart';
import 'package:programmers_network_app/view/screen/Home/ready_page.dart';
import 'package:programmers_network_app/view/screen/Home/source_page.dart';
import 'package:programmers_network_app/view/screen/auth/complete_page.dart';
import 'package:programmers_network_app/view/screen/auth/forget_page.dart';
import 'package:programmers_network_app/view/screen/auth/login_page.dart';
import 'package:programmers_network_app/view/screen/auth/register_page.dart';
import 'package:programmers_network_app/view/screen/auth/verify_page.dart';
import 'package:programmers_network_app/view/screen/profile/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  String? initialRoute;

  late AppLinks _appLinks;
  StreamSubscription<Uri>? _deepLinkSubscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    checkStart();
    _initializeDeepLinks();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("📱 APP STATE => $state");
  }

  void _initializeDeepLinks() {
    _appLinks = AppLinks();

    _deepLinkSubscription = _appLinks.uriLinkStream.listen(
      (uri) {
        debugPrint("🔗 Deep Link Received => $uri");
        // _handleDeepLink(uri);
      },
      onError: (err) {
        debugPrint("❌ Deep Link Error => $err");
      },
    );
  }

  Future<void> checkStart() async {
    /// مؤقتاً لا تمسحي التوكن أثناء الاختبار
    // await TokenStorage.clearToken();

    final prefs = await SharedPreferences.getInstance();

    final seenOnboarding = prefs.getBool('seen_onboarding') ?? false;

    if (!seenOnboarding) {
      initialRoute = AppRoute.register;
    } else {
      initialRoute = AppRoute.login;
    }

    setState(() {});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _deepLinkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initialRoute == null) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.login,
      getPages: [
        GetPage(name: AppRoute.login, page: () => LoginPage()),
        GetPage(name: AppRoute.register, page: () => RegisterPage()),
        GetPage(name: AppRoute.verify, page: () => VerifyPage()),
        GetPage(name: AppRoute.complete, page: () => CompletePage()),
        GetPage(name: AppRoute.resetpassword, page: () => ForgetPasswordPage()),
        GetPage(name: AppRoute.homePage, page: () => HomePage()),
        GetPage(name: AppRoute.source, page: () => SourcePage()),
        GetPage(name: AppRoute.profilePage, page: () => ProfilePage()),
        GetPage(name: AppRoute.readyPage, page: () => ReadyPage()),
      ],
    );
  }
}



  // Future<void> checkStart() async {
  //   final token = await TokenStorage.getToken();

  //   final prefs = await SharedPreferences.getInstance();
  //   final seenOnboarding = prefs.getBool('seen_onboarding') ?? false;

  //   if (token != null) {
  //     initialRoute = AppRoute.homePage;
  //   } else if (!seenOnboarding) {
  //     initialRoute = AppRoute.onBording;
  //   } else {
  //     initialRoute = AppRoute.login;
  //   }

  //   setState(() {});
  // }