import 'dart:convert';
import 'package:http/http.dart' as http;

import '../PoojaModel.dart';


class PoojaService {

  static const String baseUrl =
      "https://backend.kalpjyotish.com/api/All-poojas";

  static Future<List<PoojaModel>> fetchPoojas() async {

    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {

      final jsonData = json.decode(response.body);

      List data = jsonData['data'];

      return data.map((e) => PoojaModel.fromJson(e)).toList();

    } else {
      throw Exception("Failed to load poojas");
    }
  }
}