import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:udemy_flutter_delivery/src/models/response_api.dart';
import 'package:udemy_flutter_delivery/src/providers/users_provider.dart';
//Esta clase es la que rutea o nombra de cirta fomrma al las paginas que quiero cambiar o acceder
class LoginController extends GetxController{
//Con esto campturaremos los valores que el usuario ingrese
//
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isPasswordVisible = true.obs; // Inicialmente la contraseña está oculta
  UsersProvider usersProvider = UsersProvider();

  void goToRegisterPage (){//Recuerda no poner o anteponer _ ya que esto lo dejaria como privado impidiendo su uso desde otro lugar
    Get.toNamed("/register");
  }
  //Metodo que disparara al servidor para validar la base de datos
  void login() async{
    //Capturamos con un string los datos que ingrese el usuario
    String email = emailController.text.trim();//El metodo trim es para que no permita bits vacios es decir no aceptara el espacio como dato
    String password = passwordController.text.trim();
  //Para mostrar en pantalla (Consola) lo que ponga el usuario
    print("email$email");
    print("password$password");


    if (isValidForm(email, password)){
      ResponseApi responseApi = await usersProvider.login(email, password);
      print("response API: ${responseApi.toJson()}");//nos mostrara por consola los atributoa que vengan desde el servidor
      if (responseApi.success == true) {
        GetStorage().write("user", responseApi.data);//Aqui tomamos los datos de sesion del usuario
        goToHomePage();
      }
      else {
        Get.snackbar("Login Fallido", responseApi.message?? "");//Debido al NULL SAFETY el campo debe ser declarado de alguna forma por lo que debemos avisarle que si viene vacio simplemente imprima "" Nada para eso se usa ??

      }

    }

  }
  void goToHomePage() {
    Get.offNamedUntil("/home",(route) => false);
  }
  //Crearemos un metodo que retone un booleano que preguntara si el form es valido obtendremos por paramotro los 2 string
  bool  isValidForm(String email,String password){
    if (email.isEmpty){//Si el email esta vacio entonces
      Get.snackbar("Fomulario no valido", "Debes ingrear el Email");
      return false;//Retornamos false despues de mostrado el mensaje
    }
    if (!GetUtils.isEmail(email)){//Esta condicion viene de Get y valida si el campo es de tipo email por ejemplo con la pregunta "Si no es un email el campo email entonces..."
      Get.snackbar("Formulario no valido", "EL email no es valido");
      return false;//Retornamos false despues de mostrado el mensaje
    }
    if (password.isEmpty){//Si el email esta vacio entonces
      Get.snackbar("Fomulario no valido", "Debes ingrear el password");
      return false;//Retornamos false despues de mostrado el mensaje
    }
    return true;
  }

}