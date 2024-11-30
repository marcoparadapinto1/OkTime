import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/pages/Home/home_page.dart';
import 'package:udemy_flutter_delivery/src/pages/login/login_page.dart';
import 'package:udemy_flutter_delivery/src/pages/register/register_page.dart';
import 'package:udemy_flutter_delivery/src/pages/terms/terms_and_conditions_%20page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:udemy_flutter_delivery/src/pages/map/map_controller.dart';
import 'package:udemy_flutter_delivery/src/pages/map/map_page.dart';
import 'src/models/user.dart';
import 'package:udemy_flutter_delivery/src/pages/subject/subject_page.dart';
import 'package:udemy_flutter_delivery/src//pages/reminders/reminders_page.dart';
import 'package:udemy_flutter_delivery/src//pages/calendar/calendar_page.dart';

User userSession = User();
void main() async {
  await GetStorage.init();
  await GetStorage().remove("user");
  runApp(const Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}
class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapController()); // Inicializa el controlador aquí
  }
}
class _MyappState extends State<Myapp> {

  @override
  void initState() {
    // TODO: implement initState  (Aqui esdonde se inicia lo primero de la app)
    super.initState();
    userSession = User.fromJson(GetStorage().read('user') ?? {});

  }
   //metodo que contruye las vistas
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: "OkTime",
      //Quitar de de demo arriba
      debugShowCheckedModeBanner: false,
      initialRoute: "/home",//Si user session es diferente que null entonces llevelo a Home si no llevelo a /
      getPages: [// En este apartado es donde seteo las rutas para las diferentes paginas de mi app
        GetPage(name: "/", page: () => LoginPage()),
        GetPage(name: "/register", page: () => RegisterPage()),
        GetPage(name: '/terms_and_cond', page: () => TermsAndConditionsPage()),
        GetPage(name: "/home", page: () => HomePage()),
        GetPage(name: "/map", page: () => MapPage(), binding: MapBinding()),
        GetPage(name: '/subject', page: () => SubjectPage()),
        GetPage(name: '/reminders', page: () => RemindersPage()),
        GetPage(name: '/calendar', page: () => CalendarPage()),
      ],
      theme: ThemeData(//Se establecen los colores predterminados segun el modelo de movil para cuando se precionan o marcan los text field etc
        primaryColor: Colors.red,//Se define el color primario
        colorScheme: const ColorScheme(
            primary: Colors.red,
            brightness: Brightness.dark,
            secondary: Colors.redAccent,
            error: Colors.grey,
            onError: Colors.grey,
            surface: Colors.white,
            onSurface: Colors.red,
            onPrimary: Colors.red,
            onSecondary: Colors.grey,

        )
      ).copyWith(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.red,
            unselectedItemColor: Colors.red,
        ),
      ),
      navigatorKey: Get.key,
    );
  }
}
