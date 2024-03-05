// System
import 'package:banco_alimentos/controllers/usuariosController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

// Pages
import 'pages/dashboard.dart';

// Controllers
import 'controllers/entradasFinalizadasController.dart';
import 'controllers/tareasPendientesController.dart';
import 'controllers/catalogoProductosController.dart';
import 'controllers/entradasController.dart';
import 'controllers/crearTareaController.dart';
import 'controllers/tareasFinalizadasController.dart';
import 'controllers/mainController.dart';
import 'controllers/catalogoProveedoresController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await entradasController.init();
  await creaTareaController.init();
  await tareasFinalizadasController.init();
  await mainController.init();
  await entradasFinalizadasController.init();
  await tareasPendientesController.init();
  await catalogoProductosController.init();
  await catalogoProveedoresController.init();
  await usuariosController.init();
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

  late Timer _blinkingTimer;
  late Timer _dataFetchingTimer;

  @override
  void initState() {
    super.initState();
    //startBlinking();
    //startDataFetching();
  }

  void startBlinking() {
    _blinkingTimer = Timer.periodic(Duration(seconds: 50), (timer) {
      if (mounted) {
        setState(() {
          isRedSquareVisible = !isRedSquareVisible;
          isAmberSquareVisible = !isAmberSquareVisible;
          isGreenSquareVisible = !isGreenSquareVisible;
        });
      }
    });
  }

  void startDataFetching() {
    _dataFetchingTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (mounted) {
        setState(() {
          // Triggering a setState just to force a rebuild for data fetching
        });
      }
    });
  }

  void resetTimers() {
    _blinkingTimer.cancel();
    _dataFetchingTimer.cancel();
    startBlinking();
    startDataFetching();
  }

  @override
  void dispose() {
    _blinkingTimer.cancel();
    _dataFetchingTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('BAMX', style: GoogleFonts.montserrat())),
      ),
      body: GestureDetector(
        onTap: () {
          resetTimers();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth / 3 - 20,
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
                        ),
                      ],
                    ),
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
                        ),
                      ],
                    ),
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
                        ),
                      ],
                    ),
                    margin: EdgeInsets.all(1),
                  ),
                ],
              ),
              SizedBox(height: 50.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder<List<Map<String, dynamic>>>(
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
                      return Text('Error al obtener los datos');
                    } else {
                      return buildDataTable(snapshot.data!);
                    }
                  },
                ),
              ),
              SizedBox(height: 100.0),
              ElevatedButton(
                onPressed: () async {
                  // Navigate to the dashboard page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardPage(),
                    ),
                  );
                },
                child: Text(
                  'Operaciones',
                  style: GoogleFonts.montserrat(color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Navigate to the dashboard page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardPage(),
                    ),
                  );
                },
                child: Text(
                  'Asistencia',
                  style: GoogleFonts.montserrat(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<List<Map<String, dynamic>>> fetchData() async {
    return await mainController.readAllRows();
  }

  Widget buildDataTable(List<Map<String, dynamic>> data) {
    if (data.isEmpty) {
      return Text('No hay tareas pendientes.');
    } else {
      return DataTable(
        columns: [
          DataColumn(label: Text('Nombre')),
        ],
        rows: data.map<DataRow>((rowData) {
          return DataRow(
            cells: [
              DataCell(
                GestureDetector(
                  onTap: () {
                    // Navega a la pantalla de detalles con la información completa de la tarea
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TareaDetallesPage(data: rowData),
                      ),
                    );
                  },
                  child: Text(rowData['nombre'] ?? ''),
                ),
              ),
            ],
          );
        }).toList(),
      );
    }
  }
}

class TareaDetallesPage extends StatelessWidget {
  final Map<String, dynamic> data;

  TareaDetallesPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Tarea'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetalleItem(titulo: 'Nombre', contenido: data['nombre']),
            DetalleItem(titulo: 'Descripción', contenido: data['descripcion']),
            DetalleItem(
                titulo: 'Fecha de creación', contenido: data['fechaCreacion']),
            DetalleItem(
                titulo: 'Fecha de vencimiento',
                contenido: data['fechaVencimiento']),
            DetalleItem(titulo: 'Prioridad', contenido: data['prioridad']),
            DetalleItem(titulo: 'Estado', contenido: data['estado']),
            DetalleItem(titulo: 'Aceptado por', contenido: data['aceptadoPor']),
            DetalleItem(titulo: 'Comentarios', contenido: data['comentarios']),
            DetalleItem(titulo: 'Creado por', contenido: data['creadoPor']),
          ],
        ),
      ),
    );
  }
}

class DetalleItem extends StatelessWidget {
  final String titulo;
  final dynamic contenido;

  DetalleItem({required this.titulo, required this.contenido});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(titulo),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(contenido),
        ),
      ],
    );
  }
}
