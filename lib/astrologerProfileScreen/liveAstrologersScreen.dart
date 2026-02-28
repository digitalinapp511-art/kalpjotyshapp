import 'package:flutter/material.dart';
import 'dart:async';

import 'LiveStoryAvatar.dart';
import 'PremiumLiveCard.dart';

class LiveAstrologersScreen extends StatelessWidget {
  const LiveAstrologersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepOrange,
        title: const Text("Live Astrologers"),
      ),
      body: Column(
        children: [

          /// 🧿 Story Style Horizontal List
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              children: const [
                LiveStoryAvatar(),
                LiveStoryAvatar(),
                LiveStoryAvatar(),
                LiveStoryAvatar(),
              ],
            ),
          ),

          const SizedBox(height: 10),

          /// 🔥 Live Cards
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                PremiumLiveCard(),
                SizedBox(height: 16),
                PremiumLiveCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}