import 'package:flutter/material.dart';

class EntradasPage extends StatefulWidget {
  @override
  _EntradasPageState createState() => _EntradasPageState();
}

class _EntradasPageState extends State<EntradasPage> {
  final TextEditingController loteController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();
  final TextEditingController fabricacionController = TextEditingController();
  final TextEditingController caducidadController = TextEditingController();

  String? proveedorSeleccionado;
  String? productoSeleccionado;
  String? estadoSeleccionado;
  String? lugarSeleccionado;

  List<String> proveedores = ['Proveedor 1', 'Proveedor 2', 'Proveedor 3'];
  List<String> productos = ['Producto 1', 'Producto 2', 'Producto 3'];
  List<String> estados = ['Bueno', 'Aceptable', 'Dudoso', 'Malo'];
  List<String> lugares = ['Almacén A', 'Almacén B', 'Almacén C'];

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
                  decoration: InputDecoration(labelText: 'Número de Lote'),
                ),
                SizedBox(height: 16),
                // Añadir campo para 'fecha de recepción'
                TextFormField(
                  readOnly: true, // No editable por el usuario
                  onTap: () {
                    // Lógica para obtener la fecha del sistema del teléfono
                    // Puedes utilizar un paquete como `intl` para formatear la fecha
                  },
                  decoration: InputDecoration(labelText: 'Fecha de Recepción'),
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
                  onTap: () {
                    // Lógica para obtener la fecha de fabricación del sistema del teléfono
                    // Puedes utilizar un paquete como `intl` para formatear la fecha
                  },
                  decoration: InputDecoration(labelText: 'Fecha de Fabricación'),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: caducidadController,
                  readOnly: true, // No editable por el usuario
                  onTap: () {
                    // Lógica para obtener la fecha de caducidad del sistema del teléfono
                    // Puedes utilizar un paquete como `intl` para formatear la fecha
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
                  decoration: InputDecoration(labelText: 'Estado del Lote o Producto'),
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
                  decoration: InputDecoration(labelText: 'Lugar de Almacenamiento'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Confirmar'),
                        content: Text('¿Está seguro de agregar el registro actual?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Aquí puedes agregar la lógica para guardar el registro
                              // Puedes usar los valores de los controladores y variables seleccionadas
                              Navigator.of(context).pop();
                            },
                            child: Text('Agregar'),
                          ),
                        ],
                      ),
                    );
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
}