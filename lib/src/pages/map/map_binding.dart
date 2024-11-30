import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/pages/map/map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapController());
  }
}