import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title:   Text(
          "Astro History",
          style: GoogleFonts.montserrat(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [

          /// 🔥 CHAT HISTORY
          AstroHistoryCard(
            astroName: "Astro Raj",
            type: "Chat",
            date: "20 Feb 2026",
            duration: "12 min",
            ratePerMin: 15,
            status: "Completed",
          ),

          /// 🔥 CALL HISTORY
          AstroHistoryCard(
            astroName: "Astro Neha",
            type: "Call",
            date: "18 Feb 2026",
            duration: "8 min",
            ratePerMin: 25,
            status: "Completed",
          ),

          AstroHistoryCard(
            astroName: "Astro Vikram",
            type: "Call",
            date: "15 Feb 2026",
            duration: "5 min",
            ratePerMin: 30,
            status: "Cancelled",
          ),
        ],
      ),
    );
  }
}

class AstroHistoryCard extends StatelessWidget {
  final String astroName;
  final String type;
  final String date;
  final String duration;
  final int ratePerMin;
  final String status;

  const AstroHistoryCard({
    super.key,
    required this.astroName,
    required this.type,
    required this.date,
    required this.duration,
    required this.ratePerMin,
    required this.status,
  });

  int get totalAmount {
    final minutes = int.parse(duration.split(" ")[0]);
    return minutes * ratePerMin;
  }

  Color getStatusColor() {
    switch (status) {
      case "Completed":
        return Colors.green;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Top Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                astroName,
                style:   GoogleFonts.montserrat(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: getStatusColor().withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.montserrat(
                    color: getStatusColor(),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            type == "Chat" ? "💬 Chat Session" : "📞 Call Session",
            style: GoogleFonts.montserrat(
              color: type == "Chat" ? Colors.blue : Colors.orange,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 12),

          /// Date & Duration
          Row(
            children: [
              const Icon(Icons.calendar_today,
                  size: 16, color: Colors.grey),
              const SizedBox(width: 6),
              Text(date, style:   GoogleFonts.montserrat(color: Colors.grey)),
              const SizedBox(width: 16),
              const Icon(Icons.timer, size: 16, color: Colors.grey),
              const SizedBox(width: 6),
              Text(duration,
                  style:   GoogleFonts.montserrat(color: Colors.grey)),
            ],
          ),

          const SizedBox(height: 12),

          /// Rate + Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "₹$ratePerMin / min",
                style:   GoogleFonts.montserrat(color: Colors.grey),
              ),
              Text(
                "Total: ₹$totalAmount",
                style:   GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}