import 'dart:async';

import 'package:flutter/material.dart';
class PremiumLiveCard extends StatefulWidget {
  const PremiumLiveCard({super.key});

  @override
  State<PremiumLiveCard> createState() => _PremiumLiveCardState();
}

class _PremiumLiveCardState extends State<PremiumLiveCard> {
  bool blink = true;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 700), (_) {
      setState(() {
        blink = !blink;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [

          /// 🎥 Live Preview Thumbnail
          Container(
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1517841905240-472988babdf9"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 💎 Glass Overlay
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
            ),
          ),

          Positioned(
            top: 12,
            left: 12,
            child: Row(
              children: [

                /// 🔴 Blinking LIVE
                if (blink)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "LIVE",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                const SizedBox(width: 10),

                /// 👀 Real-time Viewers (Firebase Ready)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.remove_red_eye,
                          color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "245",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// 👤 Bottom Info
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage:
                  NetworkImage("https://i.pravatar.cc/150?img=5"),
                ),
                const SizedBox(width: 10),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pandit Rahul",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Vedic Astrology",
                        style:
                        TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Join"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}