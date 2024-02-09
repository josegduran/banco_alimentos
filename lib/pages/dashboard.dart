import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Evitar que el usuario pueda regresar a la página anterior
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Buenos días, José! ☀️'),
        ),
        drawer: _buildDrawer(context),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 16.0), // Ajusta según sea necesario
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    '¡Prioridad Alta!',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  _buildCarousel(), // Carrusel de tarjetas
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDashboardButton(CupertinoIcons.arrow_down),
                      _buildDashboardButton(CupertinoIcons.arrow_up),
                      _buildDashboardButton(CupertinoIcons.snow),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSemaphoreButton(0), // Verde
                      _buildSemaphoreButton(1), // Amarillo
                      _buildSemaphoreButton(2), // Rojo
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDashboardButton(CupertinoIcons.exclamationmark),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return Container(
      height: 150.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCard('Suministro 567', Colors.deepOrange),
          _buildCard('Suministro 756', Colors.deepOrange),
          _buildCard('Suministro 456', Colors.deepOrange),
          // Agregar más tarjetas según sea necesario
        ],
      ),
    );
  }

  Widget _buildCard(String title, Color color) {
    return Container(
      width: 200.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSemaphoreButton(int index) {
    Color iconColor;

    // Asignar el color según el índice
    switch (index) {
      case 0:
        iconColor = Colors.lightGreen;
        break;
      case 1:
        iconColor = Colors.orange;
        break;
      case 2:
        iconColor = Colors.deepOrange;
        break;
      default:
        iconColor = Colors.black;
    }

    return _buildDashboardButton(
      CupertinoIcons.stopwatch_fill,
      iconColor: iconColor,
    );
  }

  Widget _buildDashboardButton(IconData icon, {Color? iconColor}) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () {
          // Agregar lógica para el ítem correspondiente del panel de control
        },
        icon: Icon(
          icon,
          color: iconColor,
        ),
        label: SizedBox.shrink(),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menú',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Perfil'),
            onTap: () {
              // Agregar lógica para la opción 1 del menú
            },
          ),
          ListTile(
            title: Text('Contacto'),
            onTap: () {
              // Agregar lógica para la opción 2 del menú
            },
          ),
          ListTile(
            title: Text('Cerrar sesión'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}