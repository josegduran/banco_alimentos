import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:banco_alimentos/controllers/tareasIncompletasController.dart';

class TareasIncompletasPage extends StatefulWidget {
  @override
  _TareasIncompletasPageState createState() => _TareasIncompletasPageState();
}

class _TareasIncompletasPageState extends State<TareasIncompletasPage> {
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
        title: Text('Tareas Incompletas', style: GoogleFonts.montserrat()),
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
    await tareasIncompletasController.init();
    final data = await tareasIncompletasController.readAllRows();
    return data;
  }

  Widget buildDataTable(List<Map<String, dynamic>> data) {
    if (data.isEmpty) {
      return Text('No hay tareas en incompletas.');
    } else {
      return DataTable(
        columns: [
          DataColumn(label: Text('Nombre')),
          DataColumn(label: Text('Operador')),
          DataColumn(label: Text('Prioridad')),
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
                  child: Text(rowData['aceptadoPor'] ?? ''),
                ),
              ),
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
                  child: Text(rowData['prioridad'] ?? ''),
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
    int? taskId = int.tryParse(data['id'] ?? '');
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Tarea'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetalleItem(
                titulo: 'Motivo de cancelación',
                contenido: data['motivoIncompleta']),
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
            // Botón 'Tarea Incompleta'
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirmación'),
                          content: Text(
                              '¿Estás seguro de que quieres revisar esta tarea?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Cerrar el cuadro de diálogo
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancelar'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                // Obtener la fecha de hoy
                                DateTime fechaActual = DateTime.now();

                                if (taskId != null) {
                                  // Después de confirmar, actualizar el estado
                                  await tareasIncompletasController.updateEstado(
                                    id: taskId,
                                    key: 'estado',
                                    value: 'Revisada',
                                  );
                                }

                                // Mostrar un mensaje de tarea aceptada
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Tarea incompleta revisada'),
                                  ),
                                );

                                Navigator.pushReplacementNamed(context, '/');
                              },
                              child: Text('Revisar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white, // Color del texto
                  ),
                  child: Text('Revisar tarea'),
                ),
              ),
            ),
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
