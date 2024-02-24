// System
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

// Pages
import 'package:banco_alimentos/controllers/entradasController.dart';
import 'package:banco_alimentos/models/entradasModel.dart';


class EntradasPage extends StatefulWidget {
  @override
  _EntradasPageState createState() => _EntradasPageState();
}

class _EntradasPageState extends State<EntradasPage> {
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

  final TextEditingController loteController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();
  final TextEditingController fabricacionController = TextEditingController();
  final TextEditingController caducidadController = TextEditingController();

  String? proveedorSeleccionado;
  String? productoSeleccionado;
  String? estadoSeleccionado;
  String? lugarSeleccionado;
  String? colaboradorSeleccionado;

  List<String> proveedores = ['Proveedor 1', 'Proveedor 2', 'Proveedor 3'];
  List<String> productos = ['Producto 1', 'Producto 2', 'Producto 3'];
  List<String> estados = ['Bueno', 'Aceptable', 'Dudoso', 'Malo'];
  List<String> lugares = ['Almacén A', 'Almacén B', 'Almacén C'];
  List<String> colaboradores = ['Colaborador 1', 'Colaborador 2', 'Colaborador 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Registro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: loteController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Número de Lote'),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: proveedorSeleccionado,
                  onChanged: (String? value) {
                    setState(() {
                      proveedorSeleccionado = value;
                    });
                  },
                  items: proveedores.map((proveedor) {
                    return DropdownMenuItem(
                      value: proveedor,
                      child: Text(proveedor),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Proveedor'),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: productoSeleccionado,
                  onChanged: (String? value) {
                    setState(() {
                      productoSeleccionado = value;
                    });
                  },
                  items: productos.map((producto) {
                    return DropdownMenuItem(
                      value: producto,
                      child: Text(producto),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Producto'),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: cantidadController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Cantidad Recibida'),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: fabricacionController,
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
                      fabricacionController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                    }
                  },
                  decoration: InputDecoration(labelText: 'Fecha de Fabricación'),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: caducidadController,
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
                      caducidadController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
                    }
                  },
                  decoration: InputDecoration(labelText: 'Fecha de Caducidad'),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: estadoSeleccionado,
                  onChanged: (String? value) {
                    setState(() {
                      estadoSeleccionado = value;
                    });
                  },
                  items: estados.map((estado) {
                    return DropdownMenuItem(
                      value: estado,
                      child: Text(estado),
                    );
                  }).toList(),
                  decoration:
                  InputDecoration(labelText: 'Estado del Lote o Producto'),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: lugarSeleccionado,
                  onChanged: (String? value) {
                    setState(() {
                      lugarSeleccionado = value;
                    });
                  },
                  items: lugares.map((lugar) {
                    return DropdownMenuItem(
                      value: lugar,
                      child: Text(lugar),
                    );
                  }).toList(),
                  decoration:
                  InputDecoration(labelText: 'Lugar de Almacenamiento'),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: colaboradorSeleccionado,
                  onChanged: (String? value) {
                    setState(() {
                      colaboradorSeleccionado = value;
                    });
                  },
                  items: colaboradores.map((colaborador) {
                    return DropdownMenuItem(
                      value: colaborador,
                      child: Text(colaborador),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Colaborador que registra la entrada'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_validateForm()) {
                      final currentRowCount = await UserSheetsApi.getRowCount();
                      final newId = currentRowCount + 1;

                      // Obtener la fecha y hora actuales
                      DateTime fechaActual = DateTime.now();

                      final user = {
                        UserFields.id: newId,
                        UserFields.numeroLote: loteController.text,
                        UserFields.fechaRecepcion: fechaActual.toLocal().toString(),
                        UserFields.proveedor: proveedorSeleccionado,
                        UserFields.nombreProducto: productoSeleccionado,
                        UserFields.cantidadRecibida: cantidadController.text,
                        UserFields.fechaFabricacion: fabricacionController.text,
                        UserFields.fechaCaducidad: caducidadController.text,
                        UserFields.inspeccion: estadoSeleccionado,
                        UserFields.ubicacionAlmacen: lugarSeleccionado,
                        UserFields.quienRegistro: colaboradorSeleccionado,
                      };

                      await UserSheetsApi.insert([user]);

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
    if (loteController.text.isEmpty ||
        proveedorSeleccionado == null ||
        productoSeleccionado == null ||
        cantidadController.text.isEmpty ||
        fabricacionController.text.isEmpty ||
        caducidadController.text.isEmpty ||
        estadoSeleccionado == null ||
        lugarSeleccionado == null ||
        colaboradorSeleccionado == null) {
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
    loteController.clear();
    cantidadController.clear();
    fabricacionController.clear();
    caducidadController.clear();
    setState(() {
      proveedorSeleccionado = null;
      productoSeleccionado = null;
      estadoSeleccionado = null;
      lugarSeleccionado = null;
      colaboradorSeleccionado = null;
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