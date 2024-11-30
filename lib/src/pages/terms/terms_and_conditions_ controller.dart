import 'package:get/get.dart';

class TermsAndConditionsController extends GetxController {

  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Simula una carga de datos
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
    });
  }
}