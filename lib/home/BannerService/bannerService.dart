import 'dart:convert';
import 'package:http/http.dart' as http;

import '../BannerModel/bannerModel.dart';



class BannerService {
  static const String apiUrl =
      "https://backend.kalpjyotish.com/api/banners/get-banner";

  static Future<List<BannerModel>> fetchBanners() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List data = jsonData['data'];

      return data.map((e) => BannerModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load banners");
    }
  }
}