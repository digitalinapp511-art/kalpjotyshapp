import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
          "Help & Support",
          style: GoogleFonts.montserrat(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔥 Support Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFF7A45),
                    Color(0xFFFF9966),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children:   [
                  Icon(Icons.support_agent,
                      color: Colors.white, size: 40),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      "Need Immediate Help?\nOur team is here for you 24/7.",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 25),

              Text(
              "Contact Us",
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            SupportTile(
              icon: Icons.call_outlined,
              title: "Call Support",
              subtitle: "+91 9876543210",
              color: Colors.green,
            ),

            SupportTile(
              icon: Icons.email_outlined,
              title: "Email Support",
              subtitle: "support@astroapp.com",
              color: Colors.blue,
            ),

            SupportTile(
              icon: Icons.chat_bubble_outline,
              title: "Live Chat",
              subtitle: "Start chat with support team",
              color: Colors.orange,
            ),

            const SizedBox(height: 25),

              Text(
              "Frequently Asked Questions",
              style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            const FAQTile(
              question: "How wallet deduction works?",
              answer:
              "Wallet balance is deducted automatically per minute during chat or call session.",
            ),

            const FAQTile(
              question: "How can I recharge my wallet?",
              answer:
              "Go to Wallet section and choose your preferred recharge amount.",
            ),

            const FAQTile(
              question: "Can I get refund?",
              answer:
              "Refund is applicable only if session disconnects due to technical issue.",
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

/// 🔥 SUPPORT TILE
class SupportTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const SupportTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:   GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style:
                      GoogleFonts.montserrat(color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios,
              size: 16, color: Colors.grey)
        ],
      ),
    );
  }
}

/// 🔥 FAQ TILE
class FAQTile extends StatefulWidget {
  final String question;
  final String answer;

  const FAQTile({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<FAQTile> createState() => _FAQTileState();
}

class _FAQTileState extends State<FAQTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ExpansionTile(
        tilePadding:
        const EdgeInsets.symmetric(horizontal: 16),
        title: Text(widget.question),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              widget.answer,
              style:
                GoogleFonts.montserrat(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}