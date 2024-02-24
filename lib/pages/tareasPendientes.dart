import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:banco_alimentos/controllers/tareasPendientesController.dart';
import 'package:banco_alimentos/models/tareasPendientesModel.dart';

class TareasPendientesPage extends StatefulWidget {
  @override
  _TareasPendientesPageState createState() => _TareasPendientesPageState();
}

class _TareasPendientesPageState extends State<TareasPendientesPage> {
  Timer? _inactivityTimer;

  @override
  void initState() {
    super.initState();
    startInactivityTimer();
  }

  void startInactivityTimer() {
    _inactivityTimer = Timer(Duration(seconds: 5000), () {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  void resetInactivityTimer() {
    _inactivityTimer?.cancel();
    startInactivityTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tareas Pendientes', style: GoogleFonts.montserrat()),
      ),
      body: GestureDetector(
        onTap: () {
          resetInactivityTimer();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Muestra un indicador de carga centrado
                return Center(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError || snapshot.data == null) {
                // Muestra un mensaje de error si ocurre un error o si los datos son nulos
                return Text('Error al obtener los datos');
              } else {
                // Muestra los datos cuando la operación asíncrona ha terminado
                return buildDataTable(snapshot.data!);
              }
            },
          ),
        ),
      ),
    );
  }


  Future<List<Map<String, dynamic>>> fetchData() async {
    await UserSheetsApi.init();
    final data = await UserSheetsApi.readAllRows();
    return data ?? []; // Si data es nulo, devuelve una lista vacía
  }

  Widget buildDataTable(List<Map<String, dynamic>> data) {
    if (data.isEmpty) {
      return Text('No hay tareas pendientes.');
    } else {
      return DataTable(
        columns: [
          DataColumn(label: Text('Nombre')),
          DataColumn(label: Text('Prioridad')),
          DataColumn(label: Text('Acción')),
        ],
        rows: data.map<DataRow>((rowData) {
          return DataRow(
            cells: [
              DataCell(Text(rowData['nombre'] ?? '')),
              DataCell(Text(rowData['prioridad'] ?? '')),
              DataCell(ElevatedButton(
                onPressed: () {
                  print('Aceptar clicado para ${rowData['estado']}');
                },
                child: Text('Aceptar'),
              )),
            ],
          );
        }).toList(),
      );
    }
  }
}

