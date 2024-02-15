import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

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
        title: Text('Tareas Pendientes', style: GoogleFonts.montserrat()),
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
        DataColumn(label: Text('Acciones')),
      ],
      rows: [
        _buildTareaRow('Tarea 1', 'Descripción de la Tarea 1'),
        _buildTareaRow('Tarea 2', 'Descripción de la Tarea 2'),
        _buildTareaRow('Tarea 3', 'Descripción de la Tarea 3'),
        // Agrega más filas según sea necesario
      ],
    );
  }

  DataRow _buildTareaRow(String tarea, String descripcion) {
    return DataRow(cells: [
      DataCell(Text(tarea)),
      DataCell(Text(descripcion)),
      DataCell(
        ElevatedButton(
          onPressed: () {
            // Lógica para manejar la acción de "Aceptar" para la tarea
            // ...
            print('Aceptar tarea: $tarea');
          },
          child: Text('Aceptar'),
        ),
      ),
    ]);
  }
}
