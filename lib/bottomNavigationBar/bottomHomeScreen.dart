import 'package:flutter/material.dart';

import '../chatScreen/callScreen.dart';
import '../chatScreen/chatScreen.dart';
import '../home/home_screen.dart';
import '../userprofileScreen/userprofile.dart';
import 'bottomNavigationBar.dart';

class BottomHomeScreen extends StatefulWidget {
  const BottomHomeScreen({super.key});

  @override
  State<BottomHomeScreen> createState() => _BottomHomeScreenState();
}

class _BottomHomeScreenState extends State<BottomHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    Center(child:  HomeScreen()),
    Center(child: ChatScreen()),
    Center(child: CallScreen()),
    Center(child: UserProfileScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}