import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title:   Text(
          "Chat",
          style: GoogleFonts.montserrat(color: Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.tune, color: Colors.black),
          )
        ],
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
              child: Row(
                children: const [
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

          /// 👤 Astrologer Card
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 10, // 👈 yaha 2 set karo
              itemBuilder: (context, index) {
                return const AstrologerCard();
              },
            ),
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

/// 🔥 Astrologer Card Widget
class AstrologerCard extends StatelessWidget {
  const AstrologerCard({super.key});

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
              /// Profile Image with Border
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.deepOrange),
                ),
                child: const CircleAvatar(
                  radius: 35,
                  backgroundImage:
                  NetworkImage("https://i.pravatar.cc/150?img=5"),
                ),
              ),

              const SizedBox(width: 12),

              /// Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children:   [
                        Text(
                          "Sidhi",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.verified,
                            color: Colors.green, size: 16),
                      ],
                    ),
                    const SizedBox(height: 4),
                      Text("Vedic, Vastu, Prashana",
                        style: GoogleFonts.montserrat(color: Colors.grey)),
                    const SizedBox(height: 2),
                      Text("English, Hindi",
                        style: GoogleFonts.montserrat(color: Colors.grey)),
                    const SizedBox(height: 2),
                      Text("Exp : 12 Years",
                        style: GoogleFonts.montserrat(color: Colors.grey)),

                    const SizedBox(height: 6),

                    /// Rating + Price Row
                    Row(
                      children: [
                        const Icon(Icons.star,
                            color: Colors.orange, size: 16),
                        const SizedBox(width: 3),
                          Text("4.96",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500)),

                        const Spacer(),

                          Text(
                          "₹ 50/min",
                          style: GoogleFonts.montserrat(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 5),
                          Text(
                          "27/min",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 7),

              /// Call Button
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.green),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {},
                child:   Text(
                  "Chat",
                  style: GoogleFonts.montserrat(color: Colors.green),
                ),
              )
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
              child: const Text(
                "Top Rated",
                style: TextStyle(
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