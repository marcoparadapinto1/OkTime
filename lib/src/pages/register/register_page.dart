import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:udemy_flutter_delivery/src/pages/register/register_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterController controller = Get.put(RegisterController());

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _imageUser(context),
          _buttonBack(),
        ],
      ),
    );
  }

  // Widget para el formulario de registro
  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.74,
      margin: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .size
              .height * 0.2, left: 50, right: 50),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            blurRadius: 15,
            offset: Offset(0, 0.75),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _txtTitle(),
            _txtUser(),
            _txtName(),
            _txtLastName(),
            _txtPhone(),
            _txtpass(),
            _txtpassConfirm(),
            _termsAndConditionsCheckbox(),
            _btnRegister(context),
          ],
        ),
      ),
    );
  }

  // Widget para el fondo rojo
  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.35,
      color: Colors.red,
    );
  }

  // Widget para la imagen de usuario
  Widget _imageUser(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () => controller.showAlertDialog(context),
        child: GetBuilder<RegisterController>(
          builder: (value)=>CircleAvatar(
            backgroundImage: controller.imageFile != null
                ? FileImage(controller.imageFile!)
                :AssetImage("assets/img/user_profile.png")as ImageProvider,
            radius: 60,
            backgroundColor: Colors.white,
          ),

        )
      ),
    );
  }

  // Widget para el botón de retroceso
  Widget _buttonBack() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  // Widget para el título del formulario
  Widget _txtTitle() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 15),
      child: const Text(
        "Datos para el registro",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  // Widget para construir un TextField genérico
  Widget _buildTextField({
    required TextEditingController controller,
    required TextInputType keyboardType,
    required String hintText,
    required Icon prefixIcon,
    Widget? suffixIcon,
    bool obscureText = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  // Widget para el campo de correo electrónico
  Widget _txtUser() {
    return _buildTextField(
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
      hintText: "Correo electrónico",
      prefixIcon: const Icon(Icons.email),
    );
  }

  // Widget para el campo de nombre
  Widget _txtName() {
    return _buildTextField(
      controller: controller.nameController,
      keyboardType: TextInputType.text,
      hintText: "Nombre",
      prefixIcon: const Icon(Icons.person),
    );
  }

  // Widget para el campo de apellido
  Widget _txtLastName() {
    return _buildTextField(
      controller: controller.lastNameController,
      keyboardType: TextInputType.text,
      hintText: "Apellido",
      prefixIcon: const Icon(Icons.person_2_outlined),
    );
  }

  // Widget para el campo de teléfono
  Widget _txtPhone() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: IntlPhoneField(
        controller: controller.phoneController,
        decoration: const InputDecoration(
          labelText: 'Número de Teléfono',
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
        ),
        initialCountryCode: 'CL',
        onChanged: (phone) {
          print(phone.completeNumber);
        },
      ),
    );
  }

  // Widget para el campo de contraseña
  Widget _txtpass() {
    return Obx(
          () =>
          _buildTextField(
            controller: controller.passwordController,
            keyboardType: TextInputType.text,
            hintText: "Contraseña",
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordVisible.value
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: () {
                controller.isPasswordVisible.value =
                !controller.isPasswordVisible.value;
              },
            ),
            obscureText: controller.isPasswordVisible.value,
          ),
    );
  }

  // Widget para el campo de confirmación de contraseña
  Widget _txtpassConfirm() {
    return Obx(
          () =>
          _buildTextField(
            controller: controller.confirmPasswordController,
            keyboardType: TextInputType.text,
            hintText: "Confirma tu Contraseña",
            prefixIcon: const Icon(Icons.lock_clock_outlined),
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordVisible.value
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: () {
                controller.isPasswordVisible.value =
                !controller.isPasswordVisible.value;
              },
            ),
            obscureText: controller.isPasswordVisible.value,
          ),
    );
  }

  // Widget para el checkbox de términos y condiciones
  Widget _termsAndConditionsCheckbox() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 0.20),
      child: Row(
        children: [
          Obx(
                () =>
                Checkbox(
                  value: controller.isTermsAccepted.value,
                  onChanged: (bool? newValue) {
                    controller.isTermsAccepted.value = newValue!;
                  },
                ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "Leer nuestros terminos y condiciones ",
                style: const TextStyle(fontSize: 12, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: 'AQUI',
                    style: const TextStyle(fontSize: 12, color: Colors.red),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed('/terms_and_cond');
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget para el botón de registro
  Widget _btnRegister(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: ElevatedButton(
        onPressed: () => controller.register(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: const Text(
          "Registrate",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}