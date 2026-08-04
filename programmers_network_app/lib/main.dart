import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/profile/user_session_controller.dart';
import 'package:programmers_network_app/core/const/routesPage.dart';
import 'package:programmers_network_app/core/storage/token_storage.dart';
import 'package:programmers_network_app/view/screen/Home/home_page.dart';
import 'package:programmers_network_app/view/screen/Home/posts/create_post_page.dart';
import 'package:programmers_network_app/view/screen/Home/ready_page.dart';
import 'package:programmers_network_app/view/screen/Home/source_page.dart';
import 'package:programmers_network_app/view/screen/auth/complete_page.dart';
import 'package:programmers_network_app/view/screen/auth/forget_page.dart';
import 'package:programmers_network_app/view/screen/auth/login_page.dart';
import 'package:programmers_network_app/view/screen/auth/register_page.dart';
import 'package:programmers_network_app/view/screen/auth/verify_page.dart';
import 'package:programmers_network_app/view/screen/profile/profile_page.dart';
import 'package:programmers_network_app/view/screen/profile/user_activity/user_activity_page.dart';
import 'package:programmers_network_app/view/screen/profile/user_status_history/user_status_history_page.dart';
import 'package:programmers_network_app/view/widget/welcome_widget.dart';

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

  final UserSessionController _sessionController = Get.put(
    UserSessionController(),
  );
  bool _sessionStarted = false;

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

    switch (state) {
      case AppLifecycleState.resumed:
        _tryStartSession();
        break;

      case AppLifecycleState.paused:
        _tryEndSession();
        break;

      case AppLifecycleState.detached:
        _tryEndSession();
        break;

      default:
        break;
    }
  }

  Future<void> _tryStartSession() async {
    final token = await TokenStorage.getToken();
    if (token == null || token.isEmpty) return;
    if (_sessionStarted) return;

    await _sessionController.startSession();
    _sessionStarted = true;
  }

  Future<void> _tryEndSession() async {
    final token = await TokenStorage.getToken();
    if (token == null || token.isEmpty) return;
    if (!_sessionStarted) return;

    await _sessionController.endSession();
    _sessionStarted = false;
  }

  void _initializeDeepLinks() {
    _appLinks = AppLinks();

    _deepLinkSubscription = _appLinks.uriLinkStream.listen(
      (uri) {
        debugPrint("🔗 Deep Link Received => $uri");
      },
      onError: (err) {
        debugPrint("❌ Deep Link Error => $err");
      },
    );
  }

  Future<void> checkStart() async {
    initialRoute = AppRoute.welcomePage;
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
      initialRoute: AppRoute.homePage,
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
        GetPage(name: AppRoute.welcomePage, page: () => WelcomeWidget()),
        GetPage(name: AppRoute.userSession, page: () => UserActivityScreen()),
        GetPage(
          name: AppRoute.userStatus,
          page: () => UserStatusHistoryScreen(),
        ),
        GetPage(name: AppRoute.CreatePost, page: () => CreatePostPage()),
      ],
    );
  }
}
