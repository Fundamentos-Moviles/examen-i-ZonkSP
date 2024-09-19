import 'package:flutter/material.dart';
import 'package:examen1_asp/libs/constants.dart'; // Ajustar si es necesario

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List lista;

  @override
  void initState() {
    lista = List.from(listaExamen); // Utilizar la lista proporcionada
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario de Cumpleaños'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: size.height - 100, // Ajustar altura
                  width: size.width,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(40),
                    itemCount: lista.length,
                    itemBuilder: (BuildContext context, int index) {
                      var datos = lista[index].toString().split('#');
                      String id = datos[0];
                      String edad = datos[1];
                      String diaCumple = datos[2];
                      String mesCumple = datos[3];
                      String nombre = datos[4];
                      String apellidos = datos[5];
                      String descripcion = datos[6];
                      String estrellas = datos[7];

                      // Alternar entre Card1 y Card2
                      if (index % 2 == 0) {
                        return Card1(
                          id: id,
                          edad: edad,
                          diaCumple: diaCumple,
                          mesCumple: mesCumple,
                          nombre: nombre,
                          apellidos: apellidos,
                          descripcion: descripcion,
                          estrellas: estrellas,
                          showSnackBar: showSnackBar,
                        );
                      } else {
                        return Card2(
                            id,
                            diaCumple,
                            mesCumple,
                            nombre,
                            apellidos,
                            edad,
                            descripcion,
                            estrellas,
                            context,
                            index);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.black87,
              child: const Text(
                'Nombre Completo: Angel Salvador Ponce',
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Card Card2(
      String id,
      String diaCumple,
      String mesCumple,
      String nombre,
      String apellidos,
      String edad,
      String descripcion,
      String estrellas,
      BuildContext context,
      int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: () {
          final message =
              'ID: $id\nFecha de nacimiento: $diaCumple de $mesCumple\nNombre completo: $nombre $apellidos\nEdad: $edad años\nDescripción: $descripcion\nN° de estrellas: $estrellas';
          showSnackBar(context, message);
        },
        leading: Icon(
          (id == '1' || id == '5' || id == '10' || id == '15')
              ? Icons.emoji_emotions
              : Icons.cake,
          color: (id == '1' || id == '5' || id == '10' || id == '15')
              ? Colors.yellow
              : Colors.red,
        ),
        title: Text(
          '$diaCumple - $mesCumple',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$nombre $apellidos'),
            Text(descripcion),
            Row(
              children: List.generate(
                5,
                (starIndex) => Icon(
                  starIndex < int.parse(estrellas)
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            if (id == '1' ||
                id == '10' ||
                id == '15' ||
                id == '20' ||
                id == '23') {
              showSnackBar(context, 'El ID $id no puede ser eliminado');
            } else {
              showSnackBar(context, 'Eliminado el ID: $id');
              setState(() {
                lista.removeAt(index);
              });
            }
          },
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Cerrar',
        onPressed: () {
          // Cerrar snackbar
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

// Componente Card1
class Card1 extends StatelessWidget {
  final String id;
  final String edad;
  final String diaCumple;
  final String mesCumple;
  final String nombre;
  final String apellidos;
  final String descripcion;
  final String estrellas;
  final Function(BuildContext, String) showSnackBar;

  const Card1({
    Key? key,
    required this.id,
    required this.edad,
    required this.diaCumple,
    required this.mesCumple,
    required this.nombre,
    required this.apellidos,
    required this.descripcion,
    required this.estrellas,
    required this.showSnackBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: () {
          final message =
              'ID: $id\nFecha de nacimiento: $diaCumple de $mesCumple\nNombre completo: $nombre $apellidos\nEdad: $edad años\nDescripción: $descripcion\nN° de estrellas: $estrellas';
          showSnackBar(context, message);
        },
        leading: Icon(
          (id == '1' || id == '5' || id == '10' || id == '15')
              ? Icons.emoji_emotions
              : Icons.cake,
          color: (id == '1' || id == '5' || id == '10' || id == '15')
              ? Colors.yellow
              : Colors.red,
        ),
        title: Text(
          '$diaCumple - $mesCumple',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$nombre $apellidos'),
            Text(descripcion),
            Row(
              children: List.generate(
                5,
                (starIndex) => Icon(
                  starIndex < int.parse(estrellas)
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Componente Card2
class Card2 extends StatelessWidget {
  final String id;
  final String edad;
  final String diaCumple;
  final String mesCumple;
  final String nombre;
  final String apellidos;
  final String descripcion;
  final String estrellas;
  final Function(BuildContext, String) showSnackBar;

  const Card2({
    Key? key,
    required this.id,
    required this.edad,
    required this.diaCumple,
    required this.mesCumple,
    required this.nombre,
    required this.apellidos,
    required this.descripcion,
    required this.estrellas,
    required this.showSnackBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: () {
          final message =
              'ID: $id\nFecha de nacimiento: $diaCumple de $mesCumple\nNombre completo: $nombre $apellidos\nEdad: $edad años\nDescripción: $descripcion\nN° de estrellas: $estrellas';
          showSnackBar(context, message);
        },
        leading: Icon(
          Icons.cake,
          color: (id == '1' || id == '5' || id == '10' || id == '15')
              ? Colors.yellow
              : Colors.red,
        ),
        title: Text(
          '$diaCumple - $mesCumple',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$nombre $apellidos'),
            Text(descripcion),
            Row(
              children: List.generate(
                5,
                (starIndex) => Icon(
                  starIndex < int.parse(estrellas)
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            if (id == '1' ||
                id == '10' ||
                id == '15' ||
                id == '20' ||
                id == '23') {
              showSnackBar(context, 'El ID $id no puede ser eliminado');
            } else {
              showSnackBar(context, 'Eliminado el ID: $id');
            }
          },
        ),
      ),
    );
  }
}
