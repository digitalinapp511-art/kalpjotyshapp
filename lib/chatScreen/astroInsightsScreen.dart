import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AstroInsightsScreen extends StatefulWidget {
  const AstroInsightsScreen({super.key});

  @override
  State<AstroInsightsScreen> createState() =>
      _AstroInsightsScreenState();
}

class _AstroInsightsScreenState
    extends State<AstroInsightsScreen> {

  final List<String> zodiacSigns = [
    "Aries","Taurus","Gemini","Cancer",
    "Leo","Virgo","Libra","Scorpio",
    "Sagittarius","Capricorn","Aquarius","Pisces"
  ];

  String selectedZodiac = "Aries";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF7F5),
      body: Stack(
        children: [

          /// ✨ Background Stars Animation
          const StarBackground(),

          Column(
            children: [

              /// 🔥 HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                    top: 60, bottom: 20, left: 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFEFC1B7),
                      Color(0xFFF3D6C9),
                    ],
                  ),
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30)),
                ),
                child:   Text(
                  "Astro Insights",
                  style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown),
                ),
              ),

              const SizedBox(height: 15),

              /// 🔥 Zodiac Horizontal Scroll
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: zodiacSigns.length,
                  itemBuilder: (context, index) {
                    final sign = zodiacSigns[index];
                    final isSelected =
                        sign == selectedZodiac;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedZodiac = sign;
                        });
                      },
                      child: Container(
                        width: 80,
                        margin:
                        const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFEFC1B7)
                              : Colors.white,
                          borderRadius:
                          BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.05),
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.auto_awesome,
                              color: Colors.brown,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              sign,
                              style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontWeight:
                                FontWeight.w600,
                                color: isSelected
                                    ? Colors.brown
                                    : Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              /// 🔥 Horoscope Card
              Expanded(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16),
                  child: HoroscopeCard(
                    zodiac: selectedZodiac,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

/// 🔥 Horoscope Card
class HoroscopeCard extends StatefulWidget {
  final String zodiac;

  const HoroscopeCard({super.key, required this.zodiac});

  @override
  State<HoroscopeCard> createState() =>
      _HoroscopeCardState();
}

class _HoroscopeCardState
    extends State<HoroscopeCard> {

  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                HoroscopeDetailScreen(zodiac: widget.zodiac),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.05),
              blurRadius: 10,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.zodiac} Horoscope",
                  style:   GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown),
                ),
                Row(
                  children: [

                    /// ❤️ Favorite
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isFav = !isFav;
                        });
                      },
                      icon: Icon(
                        isFav
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),

                    /// 📤 Share
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                              content: Text("Shared!")),
                        );
                      },
                      icon: const Icon(Icons.share,
                          color: Colors.brown),
                    ),
                  ],
                )
              ],
            ),

            const SizedBox(height: 15),

              Text(
              "Today brings positive energy. Good time for financial planning and relationships. Stay calm and trust your intuition.",
              style: GoogleFonts.montserrat(
                  color: Colors.grey),
            ),

            const Spacer(),

              Text(
              "Tap to read full details →",
              style: GoogleFonts.montserrat(
                  color: Colors.brown,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

/// 🔥 Detail Screen
class HoroscopeDetailScreen extends StatelessWidget {
  final String zodiac;

  const HoroscopeDetailScreen(
      {super.key, required this.zodiac});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
        const Color(0xFFEFC1B7),
        title: Text("$zodiac Details",
            style:   GoogleFonts.montserrat(
                color: Colors.brown)),
        iconTheme:
        const IconThemeData(color: Colors.brown),
      ),
      body:   Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Full horoscope details with love, career, finance and health insights go here.",
          style: GoogleFonts.montserrat(fontSize: 15),
        ),
      ),
    );
  }
}

/// ✨ Animated Stars Background
class StarBackground extends StatefulWidget {
  const StarBackground({super.key});

  @override
  State<StarBackground> createState() =>
      _StarBackgroundState();
}

class _StarBackgroundState
    extends State<StarBackground> {

  final Random random = Random();
  late Timer timer;
  List<Offset> stars = [];

  @override
  void initState() {
    super.initState();
    generateStars();
    timer = Timer.periodic(
        const Duration(seconds: 2),
            (_) => generateStars());
  }

  void generateStars() {
    stars = List.generate(
        20,
            (_) => Offset(
            random.nextDouble() * 400,
            random.nextDouble() * 800));
    setState(() {});
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: StarPainter(stars),
      size: Size.infinite,
    );
  }
}

class StarPainter extends CustomPainter {
  final List<Offset> stars;

  StarPainter(this.stars);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.brown.withOpacity(0.2);

    for (var star in stars) {
      canvas.drawCircle(star, 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      true;
}