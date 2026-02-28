import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../bottomNavigationBar/bottomHomeScreen.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() =>
      _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen>
    with SingleTickerProviderStateMixin {

  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final timeController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();

  final box = GetStorage();

  String selectedGender = "Male";
  String maritalStatus = "Single";

  bool isLoading = false;
  double profileProgress = 0.0;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 700));

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
            .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward();

    nameController.addListener(updateProgress);
    dobController.addListener(updateProgress);
    timeController.addListener(updateProgress);
    cityController.addListener(updateProgress);
    stateController.addListener(updateProgress);
    countryController.addListener(updateProgress);
  }

  void updateProgress() {
    int filled = 0;

    if (nameController.text.isNotEmpty) filled++;
    if (dobController.text.isNotEmpty) filled++;
    if (timeController.text.isNotEmpty) filled++;
    if (cityController.text.isNotEmpty) filled++;
    if (stateController.text.isNotEmpty) filled++;
    if (countryController.text.isNotEmpty) filled++;

    setState(() {
      profileProgress = filled / 6;
    });
  }

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      dobController.text =
      "${picked.year}-${picked.month}-${picked.day}";
    }
  }

  Future<void> pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      timeController.text = picked.format(context);
    }
  }

  Future<void> submitProfile() async {
    if (profileProgress < 1) {
      Get.snackbar("Incomplete", "Please complete required fields");
      return;
    }

    setState(() => isLoading = true);

    final token = box.read("token");

    final response = await http.post(
      Uri.parse("https://backend.kalpjyotish.com/api/auth/user/update-profile"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode({
        "name": nameController.text,
        "dob": dobController.text,
        "timeOfBirth": timeController.text,
        "gender": selectedGender,
        "maritalStatus": maritalStatus,
        "address": addressController.text,
        "city": cityController.text,
        "state": stateController.text,
        "country": countryController.text,
      }),
    );

    setState(() => isLoading = false);

    if (response.statusCode == 200) {
      Get.offAll(
            () => BottomHomeScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 500),
      );
    } else {
      Get.snackbar("Error", "Profile update failed");
    }
  }
  File? profileImage;
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// 🌈 Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF7A45), Color(0xFFFF9966)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          /// 💎 Glass Card
          Center(
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [


                            GestureDetector(
                              onTap: pickImage,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white24,
                                backgroundImage:
                                profileImage != null ? FileImage(profileImage!) : null,
                                child: profileImage == null
                                    ? Icon(Icons.camera_alt, color: Colors.white)
                                    : null,
                              ),
                            ),
                            Text(
                              "Complete Astro Profile ✨",
                              style: GoogleFonts.montserrat(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 15),

                            LinearProgressIndicator(
                              value: profileProgress,
                              backgroundColor: Colors.white24,
                              valueColor:
                              const AlwaysStoppedAnimation(Colors.white),
                            ),

                            const SizedBox(height: 25),

                            buildField(nameController, "Full Name", Icons.person),
                            const SizedBox(height: 15),

                            buildField(dobController, "Date of Birth",
                                Icons.calendar_today,
                                readOnly: true, onTap: pickDate),
                            const SizedBox(height: 15),

                            buildField(timeController, "Time of Birth",
                                Icons.access_time,
                                readOnly: true, onTap: pickTime),
                            const SizedBox(height: 15),

                            buildField(cityController, "City", Icons.location_city),
                            const SizedBox(height: 15),

                            buildField(stateController, "State", Icons.map),
                            const SizedBox(height: 15),

                            buildField(countryController, "Country", Icons.public),
                            const SizedBox(height: 15),

                            /// Gender
                            DropdownButtonFormField<String>(
                              value: selectedGender,
                              dropdownColor: Colors.black87,
                              style: const TextStyle(color: Colors.white),
                              decoration: inputDecoration("Gender"),
                              items: ["Male", "Female", "Other"]
                                  .map((e) => DropdownMenuItem(
                                  value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (value) =>
                                  setState(() => selectedGender = value!),
                            ),

                            const SizedBox(height: 15),

                            /// Marital Status
                            DropdownButtonFormField<String>(
                              value: maritalStatus,
                              dropdownColor: Colors.black87,
                              style: const TextStyle(color: Colors.white),
                              decoration: inputDecoration("Marital Status"),
                              items: ["Single", "Married", "Divorced", "Widow"]
                                  .map((e) => DropdownMenuItem(
                                  value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (value) =>
                                  setState(() => maritalStatus = value!),
                            ),

                            const SizedBox(height: 25),

                            ElevatedButton(
                              onPressed: isLoading ? null : submitProfile,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                minimumSize:
                                const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                              ),
                              child: isLoading
                                  ? const CircularProgressIndicator()
                                  : Text(
                                "Submit",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildField(TextEditingController controller, String hint,
      IconData icon,
      {bool readOnly = false, VoidCallback? onTap}) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      style: const TextStyle(color: Colors.white),
      decoration: inputDecoration(hint).copyWith(
        prefixIcon: Icon(icon, color: Colors.white),
      ),
    );
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    );
  }

}