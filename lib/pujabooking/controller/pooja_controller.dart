import 'package:get/get.dart';
import '../model/PoojaModel.dart';
import '../model/PoojaService/poojaService.dart';

class PoojaController extends GetxController {

  var isLoading = false.obs;
  var poojaList = <PoojaModel>[].obs;

  @override
  void onInit() {
    fetchPoojas();
    super.onInit();
  }

  void fetchPoojas() async {
    try {
      isLoading(true);

      var data = await PoojaService.fetchPoojas();

      poojaList.assignAll(data);

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}