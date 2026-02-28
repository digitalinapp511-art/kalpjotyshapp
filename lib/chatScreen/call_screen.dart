import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallUIScreen extends StatefulWidget {
  final bool isVideoCall;

  const CallUIScreen({super.key, required this.isVideoCall});

  @override
  State<CallUIScreen> createState() => _CallUIScreenState();
}

class _CallUIScreenState extends State<CallUIScreen> {
  int seconds = 0;
  int coins = 50; // 👈 Starting coins
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        seconds++;

        // 🔥 Every 60 sec deduct 5 coins
        if (seconds % 60 == 0) {
          coins -= 5;

          if (coins <= 0) {
            t.cancel();
            Get.snackbar("Balance Low", "Call Ended");
            Navigator.pop(context);
          }
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String get formattedTime {
    final minutes = seconds ~/ 60;
    final remaining = seconds % 60;
    return "$minutes:${remaining.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [

          /// 🎥 Video or Audio Layout
          if (widget.isVideoCall)
            Container(
              color: Colors.black,
              child: const Center(
                child: Text(
                  "Remote User Video",
                  style: TextStyle(color: Colors.white54),
                ),
              ),
            )
          else
            const Center(
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.orange,
                child: Icon(Icons.person,
                    size: 70, color: Colors.white),
              ),
            ),

          /// 💰 Coins + Timer Top Bar
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [

                /// Name + Timer
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Astrologer Name",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formattedTime,
                      style: const TextStyle(
                          color: Colors.white70),
                    ),
                  ],
                ),

                /// Coins Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: coins < 10
                        ? Colors.red
                        : Colors.orange,
                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.monetization_on,
                          size: 16, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        coins.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight:
                            FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// 🔘 Bottom Controls
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
              const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: [

                  const CircleAvatar(
                    radius: 28,
                    backgroundColor:
                    Colors.white10,
                    child: Icon(Icons.mic,
                        color: Colors.white),
                  ),

                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.red,
                    child: IconButton(
                      icon: const Icon(
                        Icons.call_end,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        timer?.cancel();
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  if (widget.isVideoCall)
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor:
                      Colors.white10,
                      child: Icon(
                        Icons.cameraswitch,
                        color: Colors.white,
                      ),
                    )
                  else
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor:
                      Colors.white10,
                      child: Icon(
                        Icons.volume_up,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}