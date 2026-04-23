import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ChatUIScreen.dart';
import 'controllers/astro_controller.dart';
import 'models/astro_model.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final AstroController controller = Get.put(AstroController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: Text(
          "Chat",
          style: GoogleFonts.montserrat(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          /// Search Bar
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

          /// Astrologer List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                    child: CircularProgressIndicator());
              }

              if (controller.astroList.isEmpty) {
                return const Center(
                    child: Text("No Astrologer Found"));
              }

              return ListView.builder(
                padding:
                const EdgeInsets.symmetric(horizontal: 16),
                itemCount: controller.astroList.length,
                itemBuilder: (context, index) {
                  final astro =
                  controller.astroList[index];
                  return AstrologerCard(astro: astro);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

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
        border:
        Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: astro.profilePhoto != null
                ? NetworkImage(astro.profilePhoto!)
                : const NetworkImage(
                "https://i.pravatar.cc/150?img=5"),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  astro.name,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  astro.skills.join(", "),
                  style: GoogleFonts.montserrat(
                      color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  "Exp : ${astro.experience}",
                  style: GoogleFonts.montserrat(
                      color: Colors.grey),
                ),
              ],
            ),
          ),

          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                  color: Colors.green),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Get.snackbar(
                  "Chat",
                  "Start chat with ${astro.name}");
              Get.to(() => ChatUIScreen(
                astrologerName: astro.name,
              ));

            },
            child: Text(
              "Chat",
              style: GoogleFonts.montserrat(
                  color: Colors.green),
            ),
          )
        ],
      ),
    );
  }
}