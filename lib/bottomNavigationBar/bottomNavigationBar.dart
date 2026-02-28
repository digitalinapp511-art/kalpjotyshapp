import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(

          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFFFF7A45),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedHome01,
                color: Colors.red,
                size: 30.0,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon:HugeIcon(
                icon: HugeIcons.strokeRoundedBubbleChatOutcome,
                color: Colors.red,
                size: 30.0,
              ),
              label: "Chat",
            ),
            BottomNavigationBarItem(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedCalling,
                color: Colors.red,
                size: 30.0,
              ),
              label: "Call",
            ),
            BottomNavigationBarItem(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedUser,
                color: Colors.red,
                size: 30.0,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}