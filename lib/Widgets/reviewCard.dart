import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewCard extends StatelessWidget {
  final String review;
  final String name;
  final String image;
  final double rating;
  final String time;

  const ReviewCard({
    super.key,
    required this.review,
    required this.name,
    required this.image,
    required this.rating,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280, // 👈 fixed width like image
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Review Text
          Text(
            '"$review"',
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style:   GoogleFonts.montserrat(
              fontSize: 13,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 12),

          /// User Info Row
          Row(
            children: [

              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(image),
              ),

              const SizedBox(width: 8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style:   GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    time,
                    style:   GoogleFonts.montserrat(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              /// Rating Stars
              Row(
                children: List.generate(
                  rating.round(),
                      (index) => const Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 14,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}