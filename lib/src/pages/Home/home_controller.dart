import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/user.dart';

class HomeController extends GetxController{
  User user = User.fromJson(GetStorage().read("user")?? {});
  HomeController() {
    print("Usuario de sesion: ${user.toJson()}");
  }

  void singOut()async{
    await GetStorage().remove("user");
    Get.offNamedUntil("/",(route)=> false);//Elimina el historial de pantallas
  }
}