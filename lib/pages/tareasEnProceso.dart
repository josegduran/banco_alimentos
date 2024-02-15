import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';

class TareasEnProcesoPage extends StatefulWidget {
  @override
  _TareasEnProcesoPageState createState() => _TareasEnProcesoPageState();
}

class _TareasEnProcesoPageState extends State<TareasEnProcesoPage> {
  Timer? _inactivityTimer;

  @override
  void initState() {
    super.initState();
    startInactivityTimer();
  }

  void startInactivityTimer() {
    _inactivityTimer = Timer(Duration(seconds: 120), () {
      // Regresar a la página principal después de 120 segundos de inactividad
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
        title: Text('Tareas En Proceso', style: GoogleFonts.montserrat()),
      ),
      body: GestureDetector(
        onTap: () {
          // Resetea el temporizador de inactividad cuando se realiza una acción
          resetInactivityTimer();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTareasTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTareasTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('Tarea')),
        DataColumn(label: Text('Descripción')),
        DataColumn(label: Text('Operador')),
      ],
      rows: [
        _buildTareaRow('Tarea 1', 'Descripción de la Tarea 1', 'Jose Duran'),
        _buildTareaRow('Tarea 2', 'Descripción de la Tarea 2', 'Jose Duran'),
        _buildTareaRow('Tarea 3', 'Descripción de la Tarea 3', 'Jose Duran'),
        // Agrega más filas según sea necesario
      ],
    );
  }

  DataRow _buildTareaRow(String tarea, String descripcion, String operador) {
    return DataRow(cells: [
      DataCell(Text(tarea)),
      DataCell(Text(descripcion)),
      DataCell(
        TyperAnimatedTextKit(
          onTap: () {
            print("Tap Event");
          },
          text: [operador],
          textStyle: TextStyle(fontSize: 12.0, color: Colors.lightGreen),
          speed: Duration(milliseconds: 200),
        ),
      ),
    ]);
  }
}
