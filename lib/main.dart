import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:splash/screens/account_screen.dart';
import 'package:splash/screens/auth/phone_screen.dart';
import 'package:splash/screens/home_screen.dart';
import 'package:splash/screens/auth/login_screen.dart';
import 'package:splash/screens/on_boarding_screen.dart';
import 'package:splash/screens/profile_screen.dart';
import 'package:splash/screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC_WjC1yHIpIrk1D8VhgdBS54TlvN8ICgA",
      appId: "1:482986330527:android:06419d1725cd3443ba95aa",
      messagingSenderId: "482986330527",
      projectId: "gasha-f76ee",
    ),
  );
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    PhoneAuthProvider(),
    GoogleProvider(
        clientId:
            '482986330527-uk4hunqva99helce7luu6meq0ap03aj2.apps.googleusercontent.com'),
  ]);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splash',
      theme: ThemeData(
          primaryColor: Colors.blue.shade400,
          useMaterial3: true,
          fontFamily: 'Lato'),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        OnBoardingScreen.id: (context) => const OnBoardingScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        PhoneAuthScreen.id: (context) => const PhoneAuthScreen(),
        CustomRegisterScreen.id: (context) => const CustomRegisterScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        AccountScreen.id: (context) => const AccountScreen(),
        UserProfileWidget.id: (context) => UserProfileWidget()
      },
      builder: EasyLoading.init(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String id = "splash-screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final store = GetStorage();

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 1),
      () {
        // first while starting app, app will check weather the user has seen the splash
        bool? boarding = store.read('onBoarding');
        boarding == null
            ? Navigator.pushReplacementNamed(context, OnBoardingScreen.id)
            : boarding == true
                ? FirebaseAuth.instance.currentUser == null
                    ? Navigator.pushReplacementNamed(context, LoginScreen.id)
                    : Navigator.pushReplacementNamed(context, HomeScreen.id)
                :
                // if false
                Navigator.pushReplacementNamed(context, OnBoardingScreen.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    return Scaffold(
      backgroundColor: Colors.white30,
      body: Center(
        child: Image.asset("assets/images/logo.jpg"),
      ),
    );
  }
}
