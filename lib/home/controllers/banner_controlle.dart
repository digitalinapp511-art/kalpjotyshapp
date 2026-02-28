import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BannerController extends GetxController {

  var bannerImages = <String>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse("https://backend.kalpjyotish.com/api/banners/get-banner"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        List banners = data['data'];

        bannerImages.value =
            banners.map<String>((e) => e['url'].toString()).toList();
      }
    } catch (e) {
      print("Banner Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}