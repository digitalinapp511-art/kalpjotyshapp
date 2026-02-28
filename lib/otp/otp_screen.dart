import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../login/controllers/controllers.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final AuthController controller = Get.find();

  bool isResendEnabled = false;
  int secondsRemaining = 30;
  String enteredOtp = "";

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;

      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
        });
        startTimer();
      } else {
        setState(() {
          isResendEnabled = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// 🔥 TOP GRADIENT
          Container(
            height: 280,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF7A45), Color(0xFFFF9966)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          /// 🔥 WHITE CARD
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height - 200,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    const SizedBox(height: 30),

                    Image.asset("assets/logo.png", height: 80),

                    const SizedBox(height: 20),

                    Text(
                      "OTP Verification 🔐",
                      style: GoogleFonts.montserrat(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "Enter the 6-digit code sent to your mobile",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// 🔥 OTP FIELD (Correct Way)
                    OtpTextField(
                      numberOfFields: 6,
                      borderColor: const Color(0xFFFF7A45),
                      focusedBorderColor: const Color(0xFFFF7A45),
                      showFieldAsBox: true,
                      borderRadius: BorderRadius.circular(12),
                      fieldWidth: 45,
                      fieldHeight: 55,
                      filled: true,
                      fillColor: const Color(0xFFF5F6FA),
                      keyboardType: TextInputType.number,
                      onCodeChanged: (String code) {
                        enteredOtp = code;
                      },
                      onSubmit: (String otp) {
                        print("OTP Submitted: $otp");
                        controller.verifyOTP(otp);   // 🔥 Direct verify here
                      },
                    ),

                    const SizedBox(height: 30),

                    /// VERIFY BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: Obx(
                            () => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF7A45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                            print("Button Pressed");
                            print("Entered OTP: $enteredOtp");

                            if (enteredOtp.trim().length == 6) {
                              controller.verifyOTP(enteredOtp.trim());
                            } else {
                              Get.snackbar("Error", "Enter complete OTP");
                            }
                          },
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : Text(
                            "Verify OTP",
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// RESEND SECTION
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive code? ",
                          style: GoogleFonts.montserrat(
                            color: Colors.grey,
                          ),
                        ),
                        isResendEnabled
                            ? GestureDetector(
                          onTap: () {
                            controller.resendOtp();
                            setState(() {
                              secondsRemaining = 30;
                              isResendEnabled = false;
                            });
                            startTimer();
                          },
                          child: Text(
                            "Resend",
                            style: GoogleFonts.montserrat(
                              color: Colors.orange,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                            : Text(
                          "Resend in $secondsRemaining s",
                          style: GoogleFonts.montserrat(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}