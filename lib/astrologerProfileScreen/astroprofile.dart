import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Widgets/reviewCard.dart';

class AstroProfileScreen extends StatelessWidget {
  const AstroProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2EF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              /// ---------------- TOP CARD ----------------
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [

                    /// Top Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.arrow_back),
                        Row(
                          children: [
                            _circleIcon(Icons.notifications_none),
                            const SizedBox(width: 10),
                            _circleIcon(Icons.share),
                          ],
                        )
                      ],
                    ),

                    const SizedBox(height: 15),

                    /// Profile Info
                    Row(
                      children: [

                        /// Profile Image
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: const Color(0xFFFF7A45),
                                    width: 2),
                              ),
                              child: const CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                  "https://i.pravatar.cc/150?img=47",
                                ),
                              ),
                            ),

                            /// Online Dot
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: Container(
                                height: 14,
                                width: 14,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 15),

                        /// Name + Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Row(
                                children:   [
                                  Text(
                                    "Astro Yasti",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(Icons.verified,
                                      color: Colors.green, size: 18),
                                ],
                              ),

                              const SizedBox(height: 4),

                                Text(
                                "Numerology, Tarot, Face Reading",
                                style: GoogleFonts.montserrat(color: Colors.grey),
                              ),

                              const SizedBox(height: 4),

                                Text(
                                "English, Hindi, Sanskrit",
                                style: GoogleFonts.montserrat(color: Colors.grey),
                              ),

                              const SizedBox(height: 6),

                              Row(
                                children:   [
                                  Text("21297 Orders",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.grey)),
                                  SizedBox(width: 15),
                                  Text("₹ 100 Free",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.red)),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// Rating + Experience Card
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F6F4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:   [
                          Column(
                            children: [
                              Icon(Icons.star, color: Colors.orange),
                              SizedBox(height: 4),
                              Text("4.7 Rating"),
                            ],
                          ),
                          VerticalDivider(),
                          Column(
                            children: [
                              Text("10 Yrs",
                                  style:
                                  GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text("Experience"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// ---------------- ABOUT ----------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:   [
                    Text("About",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 6),
                    Text(
                        "Sidhi is a Vedic astrologer in India. She loves to help her clients when they are in need. Read more...",
                        style: GoogleFonts.montserrat(color: Colors.grey)),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              /// Gallery
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://picsum.photos/200?random=$index"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              /// Expertise
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _expertItem("Numerology"),
                    _expertItem("Kundli"),
                    _expertItem("Vedic"),
                    _expertItem("Vastu"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Check Availability Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF512F), Color(0xFFFF9966)],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child:   Center(
                    child: Text(
                      "Check Availability",
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Reviews
                Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("User Reviews",
                      style:
                      GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),

              const SizedBox(height: 30),
        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              ReviewCard(
                review:
                "Very good astrologer I believe his prediction is very accurate please consult him once.",
                name: "Ishita",
                image: "https://i.pravatar.cc/150?img=32",
                rating: 5,
                time: "2 days ago",
              ),
              ReviewCard(
                review:
                "I had great experience and really helpful decisions.",
                name: "Megha",
                image: "https://i.pravatar.cc/150?img=12",
                rating: 4,
                time: "1 week ago",
              ),
            ],
          ),
        ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _circleIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration:
      const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Icon(icon, size: 18),
    );
  }
}

/// Expertise Item
class _expertItem extends StatelessWidget {
  final String title;

  const _expertItem(this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          CircleAvatar(
          radius: 28,
          backgroundColor: Color(0xFFF8F6F4),
          child: Icon(Icons.auto_awesome, color: Colors.orange),
        ),
        const SizedBox(height: 6),
        Text(title, style:   GoogleFonts.montserrat(fontSize: 12))
      ],
    );
  }
}