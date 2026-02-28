import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'bottomNavigationBar/bottomHomeScreen.dart';
import 'login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final box = GetStorage();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    checkLogin();
    // Animation controller (Duration: 2 seconds)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    // Fade animation (opacity from 0 to 1)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    // Scale animation (zoom effect from small to normal size)
    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    // Start animation
    _controller.forward();

    // Navigate to Home Screen after 3 seconds
    Timer(const Duration(seconds: 15), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>   LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    // Dispose animation controller to free memory
    _controller.dispose();
    super.dispose();
  }
  void checkLogin() async {
    await Future.delayed(Duration(seconds: 2));

    String? token = box.read("token");

    if (token != null && token.isNotEmpty) {
      Get.offAll(() => BottomHomeScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              "assets/logo.png",
              width: 220,
            ),
          ),
        ),
      ),
    );
  }
}


// Dummy Home Screen (Replace with your actual screen)
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome to KalpJyotish",
          style: GoogleFonts.montserrat(fontSize: 22),
        ),
      ),
    );
  }
}
