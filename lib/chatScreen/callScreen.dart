import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../astrologerProfileScreen/astroprofile.dart';
import 'call_screen.dart';
import 'controllers/astro_controller.dart';
import 'models/astro_model.dart';

class CallScreen extends StatelessWidget {

  CallScreen({super.key});

  final AstroController controller = Get.put(AstroController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          "Call",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          /// 🔎 Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEFE7),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for "Astrologer"',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.mic, color: Colors.deepOrange),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          /// 🏷 Filter Chips
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildChip("All", true),
                _buildChip("Love", false),
                _buildChip("Marriage", false),
                _buildChip("Career", false),
              ],
            ),
          ),

          const SizedBox(height: 15),

          /// 👤 Astrologer List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.astroList.isEmpty) {
                return const Center(child: Text("No Astrologer Found"));
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.astroList.length,
                itemBuilder: (context, index) {
                  final astro = controller.astroList[index];
                  return AstrologerCard(astro: astro);
                },
              );
            }),
          )
        ],
      ),
    );
  }

  static Widget _buildChip(String text, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: ChoiceChip(
        label: Text(text),
        selected: isSelected,
        selectedColor: Colors.deepOrange,
        backgroundColor: Colors.white,
        labelStyle: GoogleFonts.montserrat(
          color: isSelected ? Colors.white : Colors.black,
        ),
        onSelected: (val) {},
      ),
    );
  }
}

/// 🔥 Astrologer Card Widget (Dynamic)
class AstrologerCard extends StatelessWidget {
  final AstroModel astro;

  const AstrologerCard({super.key, required this.astro});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Profile Image
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.deepOrange),
                ),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: astro.profilePhoto != null
                      ? NetworkImage(astro.profilePhoto!)
                      : const NetworkImage(
                      "https://i.pravatar.cc/150?img=5"),
                ),
              ),

              const SizedBox(width: 12),

              /// Details (Profile Open)
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.to(() => const AstroProfileScreen());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              astro.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(Icons.verified,
                              color: Colors.green, size: 16),
                        ],
                      ),
                      const SizedBox(height: 4),

                      Text(
                        astro.skills.join(", "),
                        style: GoogleFonts.montserrat(color: Colors.grey),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        "Exp : ${astro.experience}",
                        style: GoogleFonts.montserrat(color: Colors.grey),
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.orange, size: 16),
                          const SizedBox(width: 3),
                          Text(
                            "4.9",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            "₹ 30/min",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 10),

              /// Call Button
              Column(
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Get.snackbar(
                        "Calling",
                        "Calling ${astro.name}...",
                      );
                      Get.to(() => const CallUIScreen(isVideoCall: false));
                    },
                    child: Text(
                      "Audio Call",
                      style: GoogleFonts.montserrat(color: Colors.green),
                    ),
                  ),
                  /// Call Button
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Get.snackbar(
                        "Calling",
                        "Calling ${astro.name}...",
                      );
                      Get.to(() => const CallUIScreen(isVideoCall: true));
                    },
                    child: Text(
                      "Video Call",
                      style: GoogleFonts.montserrat(color: Colors.green),
                    ),
                  )
                ],
              )
              ,

            ],
          ),

          /// Top Rated Ribbon
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(
                "Top Rated",
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}