import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AstroProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String oldPrice;
  final String price;
  final String discount;

  const AstroProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.oldPrice,
    required this.price,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230, // 👈 fixed width
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// PRODUCT IMAGE
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  image,
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              /// DISCOUNT BADGE
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    discount,
                    style:    GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 8),

          /// TITLE
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style:    GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 6),

          /// PRICE ROW
          Row(
            children: [
              Text(
                oldPrice,
                style:    GoogleFonts.montserrat(
                  fontSize: 11,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                price,
                style:    GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// ADD TO CART BUTTON
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.orange.withOpacity(0.1),
            ),
            child:   Center(
              child: Text(
                "Add to Cart",
                style:  GoogleFonts.montserrat(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}