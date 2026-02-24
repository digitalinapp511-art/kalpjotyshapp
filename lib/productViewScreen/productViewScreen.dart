import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductViewScreen extends StatefulWidget {
  const ProductViewScreen({super.key});

  @override
  State<ProductViewScreen> createState() =>
      _ProductViewScreenState();
}

class _ProductViewScreenState
    extends State<ProductViewScreen> {

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F1E8),
      body: Column(
        children: [

          /// 🔥 TOP IMAGE SECTION
          Stack(
            children: [

              Container(
                height: 320,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFEFD6C3),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.network(
                    "https://m.media-amazon.com/images/I/815Ynn0E9wL._AC_UF894,1000_QL80_.jpg",
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              /// 🔥 Discount Badge
              Positioned(
                top: 60,
                left: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "25% OFF",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                        FontWeight.bold),
                  ),
                ),
              ),

              /// 🔙 Back Button
              Positioned(
                top: 50,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),

          const SizedBox(height: 20),

          /// 🔥 PRODUCT DETAILS
          Expanded(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                    Text(
                    "Original Rudraksha Mala",
                    style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight:
                        FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children:   [
                      Text(
                        "₹1999",
                        style: GoogleFonts.montserrat(
                          decoration:
                          TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "₹1499",
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight:
                          FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                    Text(
                    "Description",
                    style: GoogleFonts.montserrat(
                        fontWeight:
                        FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                    Text(
                    "This original Rudraksha Mala is "
                        "energized and suitable for meditation, "
                        "spiritual growth and protection.",
                    style: GoogleFonts.montserrat(
                        color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  /// 🔥 Quantity Selector
                  Row(
                    children: [

                        Text(
                        "Quantity:",
                        style: GoogleFonts.montserrat(
                            fontWeight:
                            FontWeight.w600),
                      ),

                      const SizedBox(width: 20),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [

                            IconButton(
                              icon:
                              const Icon(Icons.remove),
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() {
                                    quantity--;
                                  });
                                }
                              },
                            ),

                            Text(
                              quantity.toString(),
                              style:
                                GoogleFonts.montserrat(
                                  fontSize: 16),
                            ),

                            IconButton(
                              icon:
                              const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  const Spacer(),

                  /// 🔥 Buttons
                  Row(
                    children: [

                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.brown,
                            padding:
                            const EdgeInsets.symmetric(
                                vertical: 14),
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                  12),
                            ),
                          ),
                          onPressed: () {},
                          child:
                          const Text("Add to Cart"),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.orange,
                            padding:
                            const EdgeInsets.symmetric(
                                vertical: 14),
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                  12),
                            ),
                          ),
                          onPressed: () {},
                          child:
                          const Text("Buy Now"),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}