import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/pages/terms/terms_and_conditions_%20controller.dart';

class TermsAndConditionsPage extends StatelessWidget {
  TermsAndConditionsController con = Get.put(TermsAndConditionsController());

  TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Términos y Condiciones'),
      ),
      body: Obx(() => con.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ley Chilena de Protección de Datos Personales
            SizedBox(height: 24),
            Text(
              'Ley Chilena de Protección de Datos Personales',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'En cumplimiento de la Ley N° 19.628 sobre Protección de la Vida Privada y sus modificaciones,  se compromete a proteger la privacidad de tus datos personales.',
              style: TextStyle(fontSize: 14),
            ),
            // Recopilación y Uso de Datos
            SizedBox(height: 24),
            Text(
              'Recopilación y Uso de Datos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Recopilamos información personal como tu nombre, correo electrónico, número de teléfono, etc., para los siguientes fines:',
              style: TextStyle(fontSize: 14),
            ),
            // Lista de fines
            Padding(
              padding: EdgeInsets.only(left: 16.0), // Agrega padding a la izquierda para la lista
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '* Crear y gestionar tu cuenta.',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '* Proporcionarte los servicios solicitados.',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '* Mejorar nuestros servicios y ofrecerte una experiencia personalizada.',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '* Enviarte comunicaciones relevantes, como promociones y actualizaciones.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            // Tus Derechos
            SizedBox(height: 24),
            Text(
              'Tus Derechos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Tienes derecho a:',
              style: TextStyle(fontSize: 14),
            ),
            // Lista de derechos
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '* Acceder a tus datos personales.',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '* Rectificar cualquier información incorrecta.',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '* Cancelar tus datos si ya no son necesarios.',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '* Oponerte al uso de tus datos para fines específicos.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            // Seguridad de la Información
            SizedBox(height: 24),
            Text(
              'Seguridad de la Información',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Implementamos medidas de seguridad para proteger tus datos personales contra acceso no autorizado, uso indebido o divulgación.',
              style: TextStyle(fontSize: 14),
            ),
            // Transferencia de Datos
            SizedBox(height: 24),
            Text(
              'Transferencia de Datos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'No compartiremos tus datos personales con terceros, excepto cuando sea necesario para proporcionarte nuestros servicios o cuando lo exija la ley.',
              style: TextStyle(fontSize: 14),
            ),
            // Cambios en la Política de Privacidad
            SizedBox(height: 24),
            Text(
              'Cambios en la Política de Privacidad',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Podemos actualizar esta política de privacidad en cualquier momento. Te notificaremos de cualquier cambio significativo.',
              style: TextStyle(fontSize: 14),
            ),
            // Contacto
            SizedBox(height: 24),
            Text(
              'Contacto',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Si tienes alguna pregunta o inquietud sobre nuestra política de privacidad, contáctanos a través de [correo electrónico o formulario de contacto].',
              style: TextStyle(fontSize: 14),
            ),
            // Consentimiento
            SizedBox(height: 24),
            Text(
              'Consentimiento',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Al utilizar nuestros servicios, aceptas los términos de esta política de privacidad y el tratamiento de tus datos personales según lo descrito anteriormente.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      )),
    );
  }
}