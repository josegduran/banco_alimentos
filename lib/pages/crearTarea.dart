// System
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

// Pages
import 'package:banco_alimentos/controllers/crearTareaController.dart';
import 'package:banco_alimentos/models/crearTareaModel.dart';


class CrearTareaPage extends StatefulWidget {
  @override
  _CrearTareaPageState createState() => _CrearTareaPageState();
}

class _CrearTareaPageState extends State<CrearTareaPage> {
  Timer? _inactivityTimer;

  @override
  void initState() {
    super.initState();
    startInactivityTimer();
  }

  void startInactivityTimer() {
    _inactivityTimer = Timer(Duration(seconds: 5000), () {
      // Regresar a la página principal después de 120 segundos de inactividad
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  void resetInactivityTimer() {
    _inactivityTimer?.cancel();
    startInactivityTimer();
  }

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController fechaVencimientoController = TextEditingController();
  final TextEditingController comentariosController = TextEditingController();

  String? prioridadSeleccionado;

  List<String> prioridades = ['Baja', 'Media', 'Alta'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear tarea'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nombreController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Nombre'),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: descripcionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Descripción'),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: fechaVencimientoController,
                  readOnly: true, // No editable por el usuario
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (selectedDate != null) {
                      // Formatea la fecha seleccionada y establece el texto en el controlador
                      fechaVencimientoController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                    }
                  },
                  decoration: InputDecoration(labelText: 'Fecha de vencimiento'),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: prioridadSeleccionado,
                  onChanged: (String? value) {
                    setState(() {
                      prioridadSeleccionado = value;
                    });
                  },
                  items: prioridades.map((prioridad) {
                    return DropdownMenuItem(
                      value: prioridad,
                      child: Text(prioridad),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Prioridad'),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: comentariosController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Comentarios'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_validateForm()) {
                      final currentRowCount = await creaTareaController.getRowCount();
                      print('Current ID:');
                      print(currentRowCount);
                      final newId = currentRowCount + 1;

                      // Obtener la fecha y hora actuales
                      DateTime fechaActual = DateTime.now();

                      final user = {
                        UserFields.id: newId,
                        UserFields.nombre: nombreController.text,
                        UserFields.descripcion: descripcionController.text,
                        UserFields.fechaCreacion: fechaActual.toLocal().toString(),
                        UserFields.fechaVencimiento: fechaVencimientoController.text,
                        UserFields.prioridad: prioridadSeleccionado,
                        UserFields.estado: 'Pendiente',
                        UserFields.aceptadoPor: 'Pendiente',
                        UserFields.comentarios: comentariosController.text,
                        UserFields.creadoPor: 'Jefe de Almacén',
                        UserFields.revisadoPor: 'Pendiente',
                        UserFields.fechaAceptacion: 'Pendiente',
                        UserFields.fechaFinalizacion: 'Pendiente',
                      };
                      print('Datos a insertar:');
                      print(user);
                      await creaTareaController.insert([user]);


                      // Limpiar formulario
                      _clearForm();

                      // Mostrar mensaje de éxito
                      _showSuccessDialog();
                    }
                  },
                  child: Text('Agregar Registro'),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validateForm() {
    // Validar que todos los campos estén llenos
    if (nombreController.text.isEmpty ||
        descripcionController.text.isEmpty ||
        fechaVencimientoController.text.isEmpty ||
        prioridadSeleccionado == null ||
        comentariosController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Todos los campos deben estar llenos.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return false;
    }
    return true;
  }

  void _clearForm() {
    // Limpiar todos los controladores y variables de selección
    nombreController.clear();
    descripcionController.clear();
    fechaVencimientoController.clear();
    comentariosController.clear();
    setState(() {
      prioridadSeleccionado = null;
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Éxito'),
        content: Text('El registro se agregó correctamente.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    super.dispose();
  }
}
