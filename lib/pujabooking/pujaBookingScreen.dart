import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PujaBookingScreen extends StatelessWidget {
  const PujaBookingScreen({super.key});

  Future<void> openWhatsApp(String pujaName) async {
    const String phoneNumber = "919876543210"; // 👈 apna number daale
    final String message = "Hello, I want to book $pujaName.";

    final Uri url = Uri.parse(
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text("Puja Booking"),
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          PujaCard(
            title: "LAKSHMI PUJA",
            price: "₹5100/-",
            image:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1QZW-AVaIRwuUzT1ARVxTECZcIBIwbTLwnA&s",
          ),
          SizedBox(height: 15),
          PujaCard(
            title: "Diwali Puja",
            oldPrice: "₹5100",
            price: "₹2100/-",
            image:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7al09J8wUF_p98wDFp9lM38TDwOJJDeA17Q&s",
          ),
        ],
      ),
    );
  }
}

class PujaCard extends StatelessWidget {
  final String title;
  final String price;
  final String? oldPrice;
  final String image;

  const PujaCard({
    super.key,
    required this.title,
    required this.price,
    this.oldPrice,
    required this.image,
  });

  Future<void> openWhatsApp(String pujaName) async {
    const String phoneNumber = "919876543210";
    final String message = "Hello, I want to book $pujaName.";

    final Uri url = Uri.parse(
        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}");

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

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
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15),
            ),
            child: Image.network(
              image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                /// Title + Price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:   GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        if (oldPrice != null)
                          Text(
                            oldPrice!,
                            style:   GoogleFonts.montserrat(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                            ),
                          ),
                        if (oldPrice != null)
                          const SizedBox(width: 6),
                        Text(
                          price,
                          style:   GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                /// Book Button
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.orange),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    openWhatsApp(title);
                  },
                  child:   Text(
                    "Book Now",
                    style: GoogleFonts.montserrat(color: Colors.orange),
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