import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Widgets/VoiceSearchBar.dart';
import '../Widgets/astroProductCard.dart';
import '../chatScreen/astroInsightsScreen.dart';
import '../chatScreen/callScreen.dart';
import '../chatScreen/chatScreen.dart';
import '../productViewScreen/productViewScreen.dart';
import '../pujabooking/pujaBookingScreen.dart';
import '../userprofileScreen/notificationScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E7DF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// ---------------- TOP GRADIENT HEADER ----------------
              Container(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFEFC1B7), Color(0xFFF3D6C9)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    /// HEADER ROW
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(
                            "https://i.pravatar.cc/150?img=5",
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ravi",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Welcome!",
                                style: GoogleFonts.montserrat(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        _circleIcon(Icons.language),
                        const SizedBox(width: 8),
                        _circleIcon(Icons.card_giftcard),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const NotificationScreen(),
                              ),
                            );
                          },
                          child: _circleIcon(Icons.notifications_none),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),
                    VoiceSearchBar(),
                    // /// SEARCH
                    // Container(
                    //   height: 48,
                    //   padding: const EdgeInsets.symmetric(horizontal: 14),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(25),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Icon(Icons.search, color: Colors.grey),
                    //       SizedBox(width: 8),
                    //       Expanded(
                    //         child: Text(
                    //           "Search for “Astrologer”",
                    //           style: GoogleFonts.montserrat(color: Colors.grey),
                    //         ),
                    //       ),
                    //       Icon(Icons.mic, color: Colors.deepOrange),
                    //     ],
                    //   ),
                    // ),

                    const SizedBox(height: 22),

                    /// TITLE
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          Color(0xFFFF3D00), // Orange
                          Color(0xFFFF6A00), // Light Orange
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds),
                      child: Text(
                        "IT'S ASTRO TIME",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 42,
                          fontWeight: FontWeight.w900,
                          color: Colors.white, // Required for ShaderMask
                          letterSpacing: 1,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // --------- SUB TITLE ----------
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFFFF3D00), Color(0xFFFF6A00)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds),
                      child: Text(
                        "PLUS DAILY INSIGHTS | 7PM – 9 PM",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    /// BUTTON
                    GestureDetector(
                      onTap: () {
                        print("Button Clicked");
                      },
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFF512F), // Dark Orange
                                Color(0xFFFF9966), // Light Orange
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.orange.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Text(
                            "GET YOUR DAILY HOROSCOPE",
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    /// SLIDER
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 170,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                      items: List.generate(
                        3,
                        (index) => ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            "https://www.astrosage.com/images/software/banner-4-en.jpg",
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// ---------------- SERVICES ----------------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ChatScreen(),
                                ),
                              );
                            },
                            child: _serviceCard(
                              "Chat",
                              "With Astrology Experts",
                              "assets/girl.png",
                              context,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CallScreen(),
                                ),
                              );
                            },
                            child: _serviceCard(
                              "Call",
                              "1:1 Personal Guidance",
                              "assets/girl1.png",
                              context,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const AstroInsightsScreen(),
                                ),
                              );
                            },
                            child: _serviceCard(
                              "Astro Insights",
                              "Astrology Readings",
                              "assets/pantit.png",
                              context,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PujaBookingScreen(),
                                ),
                              );
                            },
                            child: _serviceCard(
                              "Pooja",
                              "Personalised Pooja",
                              "assets/woman.png",
                              context,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// ---------------- FAVOURITES ----------------
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Favourite Astrologers",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      height: 190,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 150,
                            margin: const EdgeInsets.only(right: 12),
                            child: Stack(
                              children: [
                                /// -------- MAIN CARD ----------
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      /// PROFILE IMAGE WITH BORDER
                                      Stack(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: const Color(0xFFFF7A45),
                                                width: 2,
                                              ),
                                            ),
                                            child: const CircleAvatar(
                                              radius: 38,
                                              backgroundImage: NetworkImage(
                                                "https://i.pravatar.cc/150?img=8",
                                              ),
                                            ),
                                          ),

                                          /// VERIFIED BADGE
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                shape: BoxShape.circle,
                                              ),
                                              padding: const EdgeInsets.all(4),
                                              child: const Icon(
                                                Icons.check,
                                                size: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 10),

                                      /// RATING
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                            size: 16,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "4.96",
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                /// -------- PREMIUM RIBBON ----------
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFF7A45),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      "Premium",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// ---------------- FAVOURITES ----------------
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Shop",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    SizedBox(
                      height: 240,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductViewScreen(),
                                ),
                              );
                            },
                            child: AstroProductCard(
                              image:
                                  "https://m.media-amazon.com/images/I/815Ynn0E9wL._AC_UF894,1000_QL80_.jpg",
                              title: "Original Rudraksha Mala",
                              oldPrice: "₹1999",
                              price: "₹1499",
                              discount: "25% OFF",
                            ),
                          ),
                          AstroProductCard(
                            image:
                                "https://5.imimg.com/data5/SELLER/Default/2025/1/479224628/DX/UT/CA/133814943/natural-yellow-sapphire-mix-shape-size-cut-gemstone-cabochon-500x500.jpg",
                            title: "Natural Yellow Sapphire",
                            oldPrice: "₹5999",
                            price: "₹3999",
                            discount: "30% OFF",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _circleIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(icon, size: 18),
    );
  }

  static Widget _serviceCard(
    String title,
    String subtitle,
    String images,
    BuildContext context,
  ) {
    return Container(
      height: 120, // ✅ Fixed height for equal size
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// LEFT TEXT
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              /// RIGHT IMAGE
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFE5E5),
                ),
                child: ClipOval(child: Image.asset(images, fit: BoxFit.cover)),
              ),
            ],
          ),

          /// BADGE
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF512F), Color(0xFFFF9966)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "50% OFF",
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
