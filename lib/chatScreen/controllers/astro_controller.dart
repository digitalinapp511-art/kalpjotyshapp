import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/astro_model.dart';

class AstroController extends GetxController {

  var astroList = <AstroModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchAstro();
    super.onInit();
  }

  Future<void> fetchAstro() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse("https://backend.kalpjyotish.com/api/astro/get"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          List<dynamic> astroData = data['data'];

          astroList.value =
              astroData.map((e) => AstroModel.fromJson(e)).toList();
        }
      } else {
        Get.snackbar("Error", "Failed to load data");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}