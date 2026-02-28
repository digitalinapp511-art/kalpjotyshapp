import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'controller/pooja_controller.dart';
import 'model/PoojaModel.dart';

class PujaBookingScreen extends StatelessWidget {

  final PoojaController controller = Get.put(PoojaController());

  PujaBookingScreen({super.key});

  Future<void> makePhoneCall() async {
    const String phoneNumber = "tel:+919876543210"; // 👈 apna number
    final Uri url = Uri.parse(phoneNumber);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text("Puja Booking"),
        backgroundColor: Colors.orange,
      ),
      body: Obx(() {

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.poojaList.length,
          itemBuilder: (context, index) {

            final PoojaModel pooja =
            controller.poojaList[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: PujaCard(
                pooja: pooja,
                onCall: makePhoneCall,
              ),
            );
          },
        );
      }),
    );
  }
}

class PujaCard extends StatelessWidget {

  final PoojaModel pooja;
  final VoidCallback onCall;

  const PujaCard({
    super.key,
    required this.pooja,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.orange.shade200),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Image
          ClipRRect(
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(15)),
            child: pooja.image != null
                ? Image.network(
              pooja.image!,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            )
                : Container(
              height: 180,
              color: Colors.grey.shade200,
              child: const Center(child: Icon(Icons.image)),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [

                /// Title + Price
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      pooja.name,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "₹ ${pooja.price}",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                /// Call Button
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: Colors.orange),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: onCall,
                  child: Text(
                    "Call Now",
                    style: GoogleFonts.montserrat(
                        color: Colors.orange),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}