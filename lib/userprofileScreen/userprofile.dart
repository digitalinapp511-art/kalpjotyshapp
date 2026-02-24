import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bookingHistoryScreen.dart';
import 'helpSupportScreen.dart';
import 'notificationScreen.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SingleChildScrollView(
        child: Column(
          children: [

            /// 🔥 HEADER SECTION
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 60, bottom: 30, left: 20, right: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFF7A45),
                    Color(0xFFFF9966),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [

                  /// Profile Image
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage:
                    NetworkImage("https://i.pravatar.cc/150?img=32"),
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    "Ravi Sharma",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    "ravi@gmail.com",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Membership Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "🔥 Gold Member",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 💰 Wallet Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
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
                  children: [

                    /// 🔥 Top Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Wallet Balance",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "₹ 2,450",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.account_balance_wallet,
                          color: Colors.orange,
                          size: 32,
                        )
                      ],
                    ),

                    const SizedBox(height: 18),

                    /// 🔥 Add Money Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding:
                          const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(14),
                          ),
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: () {
                          showWalletRechargeSheet(context);
                          /// 👉 Yaha Recharge Screen pe navigate karo
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (_) => const WalletRechargeScreen(),
                          //   ),
                          // );
                        },
                        child:   Text(
                          "Add Money",
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// 🔥 MENU OPTIONS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children:   [



                  ProfileTile(
                    icon: Icons.history,
                    title: "Booking History",
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BookingHistoryScreen(),
                        ),
                      );
                    },
                  ),

                  ProfileTile(
                    icon: Icons.notifications_none,
                    title: "Notifications",
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationScreen(),
                        ),
                      );
                    },
                  ),


                  ProfileTile(
                    icon: Icons.help_outline,
                    title: "Help & Support",
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HelpSupportScreen(),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 10),

                  ProfileTile(
                    icon: Icons.logout,
                    title: "Logout",
                    isLogout: true,
                    onTap: (){
                      showLogoutDialog(context);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
void showWalletRechargeSheet(BuildContext context) {
  final TextEditingController amountController =
  TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius:
      BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 25,
          bottom:
          MediaQuery.of(context).viewInsets.bottom + 25,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            /// 🔥 Top Drag Line
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 20),

              Text(
              "Recharge Wallet",
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            /// 🔥 Quick Amount Options
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                rechargeChip(amountController, "100"),
                rechargeChip(amountController, "500"),
                rechargeChip(amountController, "1000"),
                rechargeChip(amountController, "2000"),
              ],
            ),

            const SizedBox(height: 20),

            /// 🔥 Custom Amount Field
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixText: "₹ ",
                hintText: "Enter custom amount",
                filled: true,
                fillColor: const Color(0xFFF4F6FA),
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// 🔥 Pay Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  String amount =
                  amountController.text.trim();

                  if (amount.isEmpty) return;

                  Navigator.pop(context);

                  /// 👉 Yaha Payment Gateway integrate karna
                  /// Razorpay / PhonePe / UPI
                },
                child:   Text(
                  "Proceed to Pay",
                  style: GoogleFonts.montserrat(
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}

/// 🔥 Quick Amount Chip Widget
Widget rechargeChip(
    TextEditingController controller, String amount) {
  return GestureDetector(
    onTap: () {
      controller.text = amount;
    },
    child: Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        "₹ $amount",
        style:   GoogleFonts.montserrat(
            color: Colors.orange,
            fontWeight: FontWeight.w600),
      ),
    ),
  );
}
void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 24, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// 🔥 Logo
              Image.asset(
                "assets/logo.png",
                height: 70,
              ),

              const SizedBox(height: 20),

                Text(
                "Logout",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

                Text(
                "Are you sure you want to logout from your account?",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(color: Colors.grey),
              ),

              const SizedBox(height: 25),

              Row(
                children: [

                  /// Cancel Button
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                  ),

                  const SizedBox(width: 12),

                  /// Logout Button
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);

                        /// 🔥 Add your logout logic here
                        /// Example:
                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(builder: (_) => LoginScreen()),
                        //   (route) => false,
                        // );
                      },
                      child: const Text("Logout"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
/// 🔥 Menu Tile
class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isLogout;
  final VoidCallback onTap;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    this.isLogout = false, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        leading: Icon(
          icon,
          color: isLogout ? Colors.red : Colors.black87,
        ),
        title: Text(
          title,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            color: isLogout ? Colors.red : Colors.black87,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}