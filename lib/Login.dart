import 'dart:math';
import 'package:examen1_asp/libs/constants.dart' as con;
import 'package:flutter/material.dart';
import 'package:examen1_asp/Home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController user = TextEditingController();
  final pass = TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: con.fondo,
          ),
          // Fondo principal con el widget separado
          const BackgroundGrid(),
          // Cuerpo del login
          Center(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Container(
                width: 500,
                padding: const EdgeInsetsDirectional.only(
                    top: 50.0, bottom: 25.0, start: 35.0, end: 35.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.black54,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Bienvenido a tu primer EXAMEN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.yellow,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // Ajuste para alinear a la izquierda el texto del label
                    Container(
                      width: double.infinity, // Ocupar todo el ancho disponible
                      child: const Text(
                        'Ingresa tu correo electrónico:',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextFormField(
                      controller: user,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Correo',
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    // Ajuste para alinear a la izquierda el texto del label
                    Container(
                      width: double.infinity, // Ocupar todo el ancho disponible
                      child: const Text(
                        'Ingresa tu contraseña:',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextFormField(
                      controller: pass,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Contraseña',
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    if (errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          errorMessage,
                          style: const TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: con.botones,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fixedSize: const Size(200, 40),
                      ),
                      onPressed: () {
                        setState(() {
                          if (user.text.isEmpty || pass.text.isEmpty) {
                            errorMessage = 'Datos incompletos';
                          } else if (user.text == "test@correo.mx" &&
                              pass.text == "FDM2") {
                            errorMessage = '';
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Home()),
                            );
                          } else {
                            if (user.text != "test@correo.mx") {
                              errorMessage = 'El correo es incorrecto';
                            } else if (pass.text != "FDM2") {
                              errorMessage = 'La contraseña es incorrecta';
                            }
                          }
                        });
                      },
                      child: const Text(
                        'Iniciar Sesión',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'Mi primer examen, ¿estará sencillo?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget separado para generar el fondo con los cuadros
class BackgroundGrid extends StatelessWidget {
  const BackgroundGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    int? emptyIndexInRow;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // Número de columnas
        childAspectRatio: 1, // Mantener cuadros cuadrados
      ),
      itemCount: 100, // Número total de cuadros
      itemBuilder: (context, index) {
        int row = index ~/ 4; // Determinar la fila actual
        int column = index % 4; // Determinar la columna actual dentro de la fila

        // Si es la primera columna de una nueva fila, generar un nuevo índice vacío
        if (column == 0) {
          emptyIndexInRow = random.nextInt(4); // Generar un índice vacío aleatorio para esa fila
        }

        // Verificar si el índice actual corresponde al índice vacío de la fila
        bool esVacio = column == emptyIndexInRow;

        // Asignar colores alternos a los cuadros
        Color colorFondo;
        if (index % 3 == 0) {
          colorFondo = con.fondo2;
        } else if (index % 3 == 1) {
          colorFondo = con.fondo3;
        } else {
          colorFondo = con.fondo4;
        }

        if (esVacio) {
          return const SizedBox.shrink(); // Cuadro vacío
        }

        return Container(
          decoration: BoxDecoration(
            color: colorFondo,
            borderRadius: BorderRadius.circular(30),
          ),
        );
      },
    );
  }
}
