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
  List<Map<String, dynamic>> allRows = [];

  @override
  void initState() {
    super.initState();
    startInactivityTimer();
    fetchData(); // Fetch data when the widget initializes
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

  Future<void> fetchData() async {
    await UserSheetsApi.init();
    final data = await UserSheetsApi.readAllRows();
    setState(() {
      allRows = data;
    });
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
          child: Column(
            children: [
              if (allRows.isEmpty)
                Text('No hay tareas pendientes.')
              else
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: allRows.length,
                  itemBuilder: (context, index) {
                    final rowData = allRows[index];
                    return _buildRowWidget(rowData);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowWidget(Map<String, dynamic> rowData) {
    // Customize this method to build a widget for each row of data
    return ListTile(
      title: Text(rowData['descripcion']),
      subtitle: Text(rowData['fechaCreacion']),
      // Add more fields as needed
    );
  }
}


