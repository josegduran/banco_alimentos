import 'package:banco_alimentos/models/usuariosModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'pages/dashboard.dart';
import 'services/api_connection.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetsApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BAMX',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'BAMX'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isRedSquareVisible = true;
  bool isAmberSquareVisible = true;
  bool isGreenSquareVisible = true;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startBlinking();
  }

  void startBlinking() {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        isRedSquareVisible = !isRedSquareVisible;
        isAmberSquareVisible = !isAmberSquareVisible;
        isGreenSquareVisible = !isGreenSquareVisible;
      });
    });
  }

  void resetTimer() {
    _timer?.cancel();
    startBlinking();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          resetTimer();
        },
        onPanUpdate: (_) {
          resetTimer();
        },
        child: WillPopScope(
          onWillPop: () async {
            // Evitar que el usuario pueda regresar a la página anterior
            return false;
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Añadir un espacio en blanco con margen
                  SizedBox(height: 50.0),
                  // Contenedor para ajustar la posición del semáforo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Aquí puedes personalizar tu semáforo horizontal
                      Container(
                        width: screenWidth / 3 - 20,
                        // Ajustar según sea necesario
                        height: 100,
                        decoration: BoxDecoration(
                            color: isRedSquareVisible
                                ? Colors.redAccent
                                : Colors.transparent,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 10),
                              )
                            ]),
                        margin: EdgeInsets.all(1),
                      ),
                      Container(
                        width: screenWidth / 3 - 20,
                        height: 100,
                        decoration: BoxDecoration(
                            color: isAmberSquareVisible
                                ? Colors.amber
                                : Colors.transparent,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 10),
                              )
                            ]),
                        margin: EdgeInsets.all(1),
                      ),
                      Container(
                        width: screenWidth / 3 - 20,
                        height: 100,
                        decoration: BoxDecoration(
                            color: isGreenSquareVisible
                                ? Colors.lightGreen
                                : Colors.transparent,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(30.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 10),
                              )
                            ]),
                        margin: EdgeInsets.all(1),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.0),
                  // Agregar la tabla con los encabezados (folio, nombre, proveedor)
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 10),
                          )
                        ]),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Folio')),
                          DataColumn(label: Text('Nombre')),
                          DataColumn(label: Text('Proveedor')),
                          DataColumn(label: Text('Cantidad')),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text('1')),
                            DataCell(Text('Nombre1')),
                            DataCell(Text('Proveedor1')),
                            DataCell(Text('Cantidad1')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('2')),
                            DataCell(Text('Nombre2')),
                            DataCell(Text('Proveedor2')),
                            DataCell(Text('Cantidad2')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('3')),
                            DataCell(Text('Nombre3')),
                            DataCell(Text('Proveedor3')),
                            DataCell(Text('Cantidad3')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('4')),
                            DataCell(Text('Nombre4')),
                            DataCell(Text('Proveedor4')),
                            DataCell(Text('Cantidad4')),
                          ]),
                          // Agregar más filas según sea necesario
                        ],
                      ),
                    ),
                  ),

                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      // Navigate to the dashboard page
                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardPage()),
                      );
                      */

                      final user = {
                        UserFields.id: 1,
                        UserFields.nombre: 'José',
                        UserFields.apellido: 'Durán',
                      };
                      await UserSheetsApi.insert([user]);
                    },
                    child: Text('Operaciones',
                        style: GoogleFonts.montserrat(color: Colors.black)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
