import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/pages/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginController controller = Get.put(LoginController());

  LoginPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 50,
        child: _textoNoTengoCuenta(),
      ),
      body: Stack(//Para poscionar encima del otro
        children: [
          _backgoundCover(context),
          _boxForm(context),
          Column(
            //Esta columna sirve para posicionar elementos uno debajo de otro de manera vertical
            children: [_imageCover(), _textAppName()],
          ),
        ],
      ),
    );
  }

  //Siempre que se coloca un _ antes de un metodo, significa que este metodo es privado sin el _ seria publico
  //Los publicos son accesibles soo dentro de la clase declarada y los privados solo son accesibles solo dentro desde la propia clase
  //Wisget para el color de fondo
  Widget _backgoundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.42,
      //Con esto aseguramos el resposive segun l pantlla y no trabajar directo con pixles
      color: Colors.red,
    );
  }
  //Widget para el texto bajo la imagen
  Widget _textAppName() {
    return const Text(
      "",
      style: TextStyle(
          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }
  //Widget para el texto de no tengo una cuenta
  Widget _textoNoTengoCuenta() {
    return Row(
      //Permite ubicar elemento uno a lalado del otro horizontalmente
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("No tienes Cuenta?",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17
            )
        ),
        const SizedBox( //Separador entre textos verticalmete
          width: 7,
        ),
        GestureDetector(//Esto habilita que el texto sea sensible a algun gesto
          onTap: ()=>controller.goToRegisterPage(),//esta parte determina que o a que me llevara cuando lo toque
          child: const Text("Registrate Aqui",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 17
            ),
          ),
        )
      ],
    );
  }
  //Widget para el boton de login
  Widget _btnLogin (){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
      child: ElevatedButton(//Este evento hara que el boton tenga dinamismoen sus estados, por ejemplo precionar etc
          onPressed: () => controller.login(),//Este evento es el que gatilla por medio de pulsaciones (Es como el onclick en kotlin) en este caso lo declaramos como funcion vacia con los parentesis vacios
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 15)
          ),
          child: const Text(
            "Login",
            style: TextStyle(
              color: Colors.black
            ),
          )
      ),
    );
  }
  //Widget para el box donde se ingresan los datos
  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.30,left: 50,right: 50),// Con esto nuevamente se establece que el mangen sera por medio de porcentage y no de pixeles para evitar que en moviles mas grandes o mas pequeños se mantengan las proporciones
      decoration: const BoxDecoration(//Se hace para dar un color al BOX de aplicaciones
        color: Colors.white,//Se define el color del box
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,//Color de la sombra
            blurRadius: 15,//Cantidad de radio de desenfocque
            offset: Offset(0,0.75)//Se define cuanto se desplaza la sombra
          )
        ]
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _txtTitle(),
            _txtUser(),
            _txtpass(),
            _btnLogin(),
            _buttonMap(context),
          ],
        ),
      ),
    );
  }
  //Widget para el text fiel (Cuadro de texto dinamico) donde esl usuari ingresa su correo o User
  Widget _txtUser (){
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller.emailController,//LLamamos al controlador que ya esta instanciado en la linea 7
        keyboardType: TextInputType.emailAddress,//Determina como se comporta el teclado segun el dato que pondra el usuario en este caso sera un correo por lo que se hace esto para que aparezca el @ de una en el teclado
        decoration: const InputDecoration(
          hintText: "Correo electronico", //Seria el equivalente al Place holder es decir el texto en gris que aparece como guia en un campo de texto o text field
          prefixIcon: Icon(Icons.email)
        ),
      ),
    );
  }
  //Widget para el text fiel (Cuadro de texto dinamico) donde esl usuari ingresa su correo o User
  Widget _txtpass() {
    return Obx(() => Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: TextField(
        controller: controller.passwordController,
        obscureText: controller.isPasswordVisible.value, // Controla la visibilidad de la contraseña
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: "Contraseña",
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              controller.isPasswordVisible.value
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
            onPressed: () {
              controller.isPasswordVisible.value = !controller.isPasswordVisible.value; // Cambia la visibilidad al presionar el icono
            },
          ),
        ),
      ),
    ));
  }
  //Widget para el text titulo de ingresa esta onfo (titulo del bos donde se piden los datos)
  Widget _txtTitle() {
    return Container(
      margin: const EdgeInsets.only(top: 40, bottom: 40),
      child: const Text(
          "Ingresa esta informacion",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black
      ),
    ),
    );
  }
  //Widget para usar la imagen y dimencionarla
  Widget _imageCover() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 15),
        alignment: Alignment.topCenter,
        child: Image.asset(
          "assets/img/logo v3.3.png",
          width: 200,
          height: 200,
        ),
      ),
    );
  }
  Widget _buttonMap(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed('/map');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(vertical: 20),
        ),
        child: Text(
          'Ir a Mapas',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

