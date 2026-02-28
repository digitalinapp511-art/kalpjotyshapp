import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get_storage/get_storage.dart';

import '../../bottomNavigationBar/bottomHomeScreen.dart';
import '../../home/complete_profile_screen.dart';
import '../../otp/otp_screen.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final box = GetStorage();

  var verificationId = ''.obs;
  var isLoading = false.obs;

  int? _resendToken;
  String? _savedPhoneNumber;

  // ================= SEND OTP =================
  Future<void> sendOTP(String phoneNumber) async {
    try {
      isLoading.value = true;

      phoneNumber = phoneNumber.replaceAll(" ", "");

      if (!phoneNumber.startsWith("+")) {
        phoneNumber = "+91$phoneNumber";
      }

      if (phoneNumber.length != 13) {
        Get.snackbar("Error", "Enter valid 10 digit phone number");
        isLoading.value = false;
        return;
      }

      _savedPhoneNumber = phoneNumber;

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        forceResendingToken: _resendToken,

        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          isLoading.value = false;
          Get.snackbar("Success", "Auto Login Successful 🎉");
        },

        verificationFailed: (FirebaseAuthException e) {
          isLoading.value = false;
          Get.snackbar("Error", e.message ?? "Verification Failed");
        },

        codeSent: (String verId, int? resendToken) {
          verificationId.value = verId;
          _resendToken = resendToken;
          isLoading.value = false;
          Get.to(() => OtpScreen());
        },

        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId;
        },
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Something went wrong");
    }
  }

  // ================= VERIFY OTP =================
  Future<void> verifyOTP(String otp) async {
    try {
      isLoading.value = true;

      if (otp.trim().length != 6) {
        Get.snackbar("Error", "Enter 6 digit OTP");
        isLoading.value = false;
        return;
      }

      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp.trim(),
      );

      await _auth.signInWithCredential(credential);

      final user = _auth.currentUser;

      if (user == null) {
        Get.snackbar("Error", "User not found");
        isLoading.value = false;
        return;
      }

      await _handleBackendLogin(user);

    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "Login Failed");
      isLoading.value = false;
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      isLoading.value = false;
    }
  }

  // ================= GOOGLE LOGIN =================
  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;

      await _googleSignIn.signOut();

      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        isLoading.value = false;
        return;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
      await _auth.signInWithCredential(credential);

      final user = userCredential.user;

      if (user == null) {
        Get.snackbar("Error", "User not found");
        isLoading.value = false;
        return;
      }

      await _handleBackendLogin(user);

    } catch (e) {
      Get.snackbar("Error", "Google login failed");
      isLoading.value = false;
    }
  }

  // ================= BACKEND LOGIN COMMON METHOD =================
  Future<void> _handleBackendLogin(User user) async {
    try {
      final response = await http.post(
        Uri.parse("https://backend.kalpjyotish.com/api/auth/user/social-login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": user.email ?? "",
          "name": user.displayName ?? "",
          "mobileNo": user.phoneNumber ?? "",
          "profile": user.photoURL ?? "",
        }),
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        String backendToken = data["token"] ?? "";
        bool profileCompleted = data["profileCompleted"] ?? false;
        bool isNewUser = data["isNewUser"] ?? false;

        await box.write("token", backendToken);

        print("isNewUser: $isNewUser");
        print("profileCompleted: $profileCompleted");

        if (!profileCompleted) {
          Get.offAll(() => const CompleteProfileScreen());
        } else {
          Get.offAll(() => BottomHomeScreen());
        }

      } else {
        Get.snackbar("Error", "Backend login failed");
      }

    } on TimeoutException {
      Get.snackbar("Error", "Server timeout. Try again.");
    } catch (e) {
      Get.snackbar("Error", "Backend error");
    } finally {
      isLoading.value = false;
    }
  }

  // ================= RESEND OTP =================
  Future<void> resendOtp() async {
    if (_savedPhoneNumber == null) {
      Get.snackbar("Error", "Phone number not found");
      return;
    }

    await sendOTP(_savedPhoneNumber!);
  }
}