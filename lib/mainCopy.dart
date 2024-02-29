import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'pages/dashboard.dart';
import 'controllers/entradasController.dart';
import 'controllers/crearTareaController.dart';
import 'controllers/mainController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await entradasController.init();
  await creaTareaController.init();
  await mainController.init();
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
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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

  Future<List<Map<String, dynamic>>> fetchData() async {
    await mainController.init();
    final data = await mainController.readAllRows();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Future<List<Map<String, dynamic>>> fetchData() async {
      await mainController.init();
      final data = await mainController.readAllRows();
      return data;
    }

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

                  // Texto 'Tareas pendientes de hoy' below the traffic light
                  SizedBox(height: 50.0),
                  Text(
                    'Hoy',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50.0),
                  // Agregar la tabla con los encabezados (folio, nombre, proveedor)
                  // Agregar la tabla con los encabezados (folio, nombre, proveedor)
                  // Integrar la lógica y apariencia de TareasPendientesPage aquí
                  // Agregar la tabla con los encabezados (folio, nombre, proveedor)
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (snapshot.hasError || snapshot.data == null) {
                        return Text('Error al obtener los datos: ${snapshot.error}');
                      } else {
                        return DataTable(
                          key: Key('dataTableKey'),
                          columns: [
                            DataColumn(label: Text('Nombre')),
                            // Add more DataColumn widgets as needed
                          ],
                          rows: snapshot.data!.map<DataRow>((rowData) {
                            return DataRow(
                              cells: [
                                DataCell(Text(rowData['nombre'] ?? '')),
                                // Adjust cells according to your data
                              ],
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),


                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      // Navigate to the dashboard page

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardPage()),
                      );
                    },
                    child: Text('Operaciones',
                        style: GoogleFonts.montserrat(color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Navigate to the dashboard page

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardPage()),
                      );
                    },
                    child: Text('Asistencia',
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
