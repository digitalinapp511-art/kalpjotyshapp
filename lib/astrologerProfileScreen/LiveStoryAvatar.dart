import 'dart:async';

import 'package:flutter/material.dart';
class LiveStoryAvatar extends StatefulWidget {
  const LiveStoryAvatar({super.key});

  @override
  State<LiveStoryAvatar> createState() => _LiveStoryAvatarState();
}

class _LiveStoryAvatarState extends State<LiveStoryAvatar> {
  bool show = true;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 800), (_) {
      setState(() {
        show = !show;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.red, Colors.orange],
                  ),
                ),
                child: const CircleAvatar(
                  radius: 30,
                  backgroundImage:
                  NetworkImage("https://i.pravatar.cc/150?img=12"),
                ),
              ),

              /// 🔴 Blinking LIVE
              if (show)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "LIVE",
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          const Text("Rahul"),
        ],
      ),
    );
  }
}