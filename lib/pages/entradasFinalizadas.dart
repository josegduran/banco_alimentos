// System
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

// Controllers
import 'package:banco_alimentos/controllers/entradasFinalizadasController.dart';

class EntradasFinalizadasPage extends StatefulWidget {
  @override
  _EntradasFinalizadasPageState createState() => _EntradasFinalizadasPageState();
}

class _EntradasFinalizadasPageState extends State<EntradasFinalizadasPage> {
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
        title: Text('Entregas Finalizadas', style: GoogleFonts.montserrat()),
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
    final data = await entradasFinalizadasController.readAllRows();
    return data;
  }

  Widget buildDataTable(List<Map<String, dynamic>> data) {
    if (data.isEmpty) {
      return Text('No hay entregas finalizadas.');
    } else {
      return DataTable(
        columns: [
          DataColumn(label: Text('Producto')),
          DataColumn(label: Text('Proveedor')),
          DataColumn(label: Text('Acción')),
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
                  child: Text(rowData['nombreProducto'] ?? ''),
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
                  child: Text(rowData['proveedor'] ?? ''),
                ),
              ),
              DataCell(ElevatedButton(
                onPressed: () {
                  // Extraer el ID de la tarea
                  int? taskId = int.tryParse(rowData['id'] ?? '');

                  // Mostrar un cuadro de diálogo para confirmar la acción
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirmación'),
                        content: Text(
                            '¿Estás seguro de que quieres revisar esta entrega?'),
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
                              // Continuar con la acción de aceptar la tarea
                              print(
                                  'Aceptar clicado para la tarea con ID: $taskId');
                              if (taskId != null) {
                                // Después de confirmar, actualizar el estado
                                await entradasFinalizadasController.updateEstado(
                                  id: taskId,
                                  key: 'estado',
                                  value: 'Revisado',
                                );

                                // Después de confirmar, actualizar el estado
                                await entradasFinalizadasController.updateColaborador(
                                  id: taskId,
                                  key: 'revisadoPor',
                                  value: 'Supervisor',
                                );
                              }

                              // Mostrar un mensaje de tarea aceptada
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Entrega Revisada'),
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
                child: Text('Revisar'),
              )),
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
        title: Text('Detalles de la entrega'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetalleItem(titulo: 'Numero de lote', contenido: data['numeroLote']),
            DetalleItem(titulo: 'Fecha de recepción', contenido: data['fechaRecepcion']),
            DetalleItem(titulo: 'Proveedor', contenido: data['proveedor']),
            DetalleItem(titulo: 'Nombre del producto', contenido: data['nombreProducto']),
            DetalleItem(titulo: 'Cantidad recibida', contenido: data['cantidadRecibida']),
            DetalleItem(titulo: 'Fecha de fabricación', contenido: data['fechaFabricacion']),
            DetalleItem(titulo: 'Fecha de caducidad', contenido: data['fechaCaducidad']),
            DetalleItem(titulo: 'Inspección', contenido: data['inspeccion']),
            DetalleItem(titulo: 'Ubicación', contenido: data['ubicacionAlmacen']),
            DetalleItem(titulo: 'Quién registró', contenido: data['quienRegistro']),
            DetalleItem(titulo: 'Estado', contenido: data['estado']),
            DetalleItem(titulo: 'Revisado por', contenido: data['revisadoPor']),
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
