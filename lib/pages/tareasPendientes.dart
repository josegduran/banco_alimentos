// System
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

// Controllers
import 'package:banco_alimentos/controllers/tareasPendientesController.dart';
import 'package:banco_alimentos/controllers/usuariosController.dart';

// Models
import 'package:banco_alimentos/models/usuariosModel.dart';

class TareasPendientesPage extends StatefulWidget {
  @override
  _TareasPendientesPageState createState() => _TareasPendientesPageState();
}

class _TareasPendientesPageState extends State<TareasPendientesPage> {
  Usuarios? _selectedUsuario;
  Timer? _inactivityTimer;

  List<Map<String, dynamic>> _tareasPendientes = [];

  @override
  void initState() {
    super.initState();
    _selectedUsuario = null;
    startInactivityTimer();
    _loadTareasPendientes(); // Llama a esta función en initState
  }

  Future<void> _loadTareasPendientes() async {
    final data = await tareasPendientesController.readAllRows();
    setState(() {
      _tareasPendientes = data;
    });
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

  Future<List<Usuarios>> fetchUsuarios() async {
    final usuariosData = await usuariosController.readAllRows();
    final usuariosList = usuariosData.map((userData) => Usuarios.fromMap(userData)).toList();
    return usuariosList;
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
    final data = await tareasPendientesController.readAllRows();
    return data;
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
                  child: Text(rowData['prioridad'] ?? ''),
                ),
              ),
              DataCell(
                ElevatedButton(
                  onPressed: () {
                    // Extraer el ID de la tarea
                    int? taskId = int.tryParse(rowData['id'] ?? '');

                    // Mostrar un cuadro de diálogo para confirmar la acción
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirmación'),
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text('¿Quién está aceptando la tarea?'),
                                SizedBox(height: 16),
                                FutureBuilder<List<Usuarios>>(
                                  future: fetchUsuarios(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError || !snapshot.hasData) {
                                      return Text('Error al obtener la lista de usuarios');
                                    } else {
                                      return DropdownButtonFormField<Usuarios>(
                                        value: _selectedUsuario,
                                        onChanged: (Usuarios? value) {
                                          setState(() {
                                            _selectedUsuario = value;
                                          });
                                        },
                                        items: snapshot.data!.map((usuario) {
                                          return DropdownMenuItem<Usuarios>(
                                            value: usuario,
                                            child: Text(usuario.nombreApellido ?? 'SinNombre'),
                                          );
                                        }).toList(),
                                        decoration: InputDecoration(labelText: 'Usuario'),
                                      );
                                  }
                                  },
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // Cerrar el cuadro de diálogo y limpiar el usuario seleccionado
                                setState(() {
                                  _selectedUsuario = null;
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancelar'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                // Obtener la fecha de hoy
                                DateTime fechaActual = DateTime.now();

                                if (taskId != null && _selectedUsuario != null) {
                                  // Después de confirmar, actualizar el estado
                                  await tareasPendientesController.updateEstado(
                                    id: taskId,
                                    key: 'estado',
                                    value: 'En Proceso',
                                  );

                                  // Después de confirmar, actualizar el estado
                                  await tareasPendientesController.updateColaborador(
                                    id: taskId,
                                    key: 'aceptadoPor',
                                    value: _selectedUsuario!.nombreApellido ?? '',
                                  );

                                  await tareasPendientesController.updateFechaAceptacion(
                                    id: taskId,
                                    key: 'fechaAceptacion',
                                    value: fechaActual.toLocal().toString(),
                                  );

                                  // Mostrar un mensaje de tarea aceptada
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Tarea Aceptada'),
                                    ),
                                  );

                                  Navigator.pushReplacementNamed(context, '/');
                                } else {
                                  Navigator.of(context).pop();
                                  // Mostrar un mensaje de advertencia de que se debe seleccionar un usuario
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Debes seleccionar un usuario para aceptar la tarea.'),
                                    ),
                                  );
                                }
                              },
                              child: Text('Aceptar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Aceptar'),
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
