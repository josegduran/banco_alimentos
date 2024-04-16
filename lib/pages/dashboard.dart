// System
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

// Pages
import 'tareasPendientes.dart';
import 'tareasEnProceso.dart';
import 'tareasIncompletas.dart';
import 'package:banco_alimentos/pages/crearTarea.dart';
import 'package:banco_alimentos/pages/entradas.dart';
import 'package:banco_alimentos/pages/operacionesFinalizadas.dart';

// Models
import 'package:banco_alimentos/models/entradasModel.dart';

// Controllers
import 'package:banco_alimentos/controllers/entradasController.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: GoogleFonts.montserrat(),
      child: WillPopScope(
        onWillPop: () async {
          // Evitar que el usuario pueda regresar a la página anterior
          return true;
        },
        child: GestureDetector(
          onTap: () {
            resetInactivityTimer();
          },
          onPanUpdate: (_) {
            resetInactivityTimer();
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text('Buen día ☀️', style: GoogleFonts.montserrat()),
            ),
            drawer: _buildDrawer(context),
            body: SingleChildScrollView(
              padding: EdgeInsets.only(top: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Próximos a vencer',
                          style: GoogleFonts.montserrat()),
                      const SizedBox(height: 20.0),
                      _buildCarousel(),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDashboardButton(
                            CupertinoIcons.clock,
                            iconColor: Colors.black,
                            onPressed: () {
                              // Navegar a la página de Tareas Pendientes cuando se presiona el icono del reloj
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TareasPendientesPage()),
                              );
                            },
                          ),
                          const SizedBox(width: 10.0),
                          _buildDashboardButton(
                            CupertinoIcons.rocket,
                            iconColor: Colors.black,
                            onPressed: () {
                              // Navegar a la página de Tareas Pendientes cuando se presiona el icono del reloj
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TareasEnProcesoPage()),
                              );
                            },
                          ),
                          const SizedBox(width: 10.0),
                          _buildDashboardButton(
                            CupertinoIcons.check_mark_circled,
                            iconColor: Colors.black,
                            onPressed: () {
                              // Navegar a la página de Tareas Pendientes cuando se presiona el icono del reloj
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OperacionesFinalizadasPage()),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDashboardButton(
                            CupertinoIcons.arrow_down,
                            iconColor: Colors.black,
                            onPressed: () {
                              // Navegar a la página de Tareas Pendientes cuando se presiona el icono del reloj
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EntradasPage()),
                              );
                            },
                          ),
                          const SizedBox(width: 10.0),
                          _buildDashboardButton(CupertinoIcons.arrow_up,
                              iconColor: Colors.black),
                          const SizedBox(width: 10.0),
                          _buildDashboardButton(
                            CupertinoIcons.exclamationmark,
                            iconColor: Colors.black,
                            onPressed: () {
                              // Navegar a la página de Tareas Pendientes cuando se presiona el icono del reloj
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TareasIncompletasPage()),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDashboardButton(CupertinoIcons.question_circle,
                              iconColor: Colors.black),
                          const SizedBox(width: 10.0),
                          _buildDashboardButton(
                            CupertinoIcons.pencil,
                            iconColor: Colors.black,
                            onPressed: () {
                              // Navegar a la página de Tareas Pendientes cuando se presiona el icono del reloj
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CrearTareaPage()),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<List<EntradasPorVencer>> fetchDataForCarousel() async {
    try {
      final entriesToDisplay = await entradasController.readAllRows();

      print('Datos del carrusel: $entriesToDisplay');

      return entriesToDisplay;
    } catch (e) {
      print('Error en fetchDataForCarousel: $e');
      return [];
    }
  }

  Widget _buildCarousel() {
    return Container(
      height: 150.0,
      child: FutureBuilder<List<EntradasPorVencer>>(
        future: fetchDataForCarousel(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError || snapshot.data == null) {
            return Text('Error al obtener los datos del carrusel');
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text('No hay lotes próximos a vencer'),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TareaDetallesPage(data: snapshot.data![index]),
                      ),
                    );
                  },
                  child: _buildCard(
                      snapshot.data![index].nombreProducto, Colors.redAccent),
                );
              },
            );
          }
        },
      ),
    );
  }


  Widget _buildCard(String title, Color color) {
    return Container(
      width: 200.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.montserrat(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardButton(IconData icon,
      {Color? iconColor, VoidCallback? onPressed}) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: iconColor,
        ),
        label: SizedBox.shrink(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 10,
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      width: 200,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  'Menú',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text('Contacto', style: GoogleFonts.montserrat()),
            onTap: () {
              // Agregar lógica para la opción 1 del menú
            },
          ),
          ListTile(
            title: Text('Reportar problema', style: GoogleFonts.montserrat()),
            onTap: () {
              // Agregar lógica para la opción 2 del menú
            },
          ),
          ListTile(
            title: Text('Lobby', style: GoogleFonts.montserrat()),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
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

class TareaDetallesPage extends StatelessWidget {
  final EntradasPorVencer data;

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
            DetalleItem(titulo: 'Numero de lote', contenido: data.numeroLote),
            DetalleItem(
                titulo: 'Fecha de recepción', contenido: data.fechaRecepcion),
            DetalleItem(titulo: 'Proveedor', contenido: data.proveedor),
            DetalleItem(
                titulo: 'Nombre del producto', contenido: data.nombreProducto),
            DetalleItem(
                titulo: 'Cantidad recibida', contenido: data.cantidadRecibida),
            DetalleItem(
                titulo: 'Fecha de fabricación',
                contenido: data.fechaFabricacion),
            DetalleItem(
                titulo: 'Fecha de caducidad', contenido: data.fechaCaducidad),
            DetalleItem(titulo: 'Inspección', contenido: data.inspeccion),
            DetalleItem(titulo: 'Ubicación', contenido: data.ubicacionAlmacen),
            DetalleItem(
                titulo: 'Quién registró', contenido: data.quienRegistro),
            DetalleItem(titulo: 'Estado', contenido: data.estado),
            DetalleItem(titulo: 'Revisado por', contenido: data.revisadoPor),
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
