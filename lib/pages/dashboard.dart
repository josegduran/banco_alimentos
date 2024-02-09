import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: GoogleFonts.montserrat(), // Establece Montserrat como la fuente predeterminada
      child: WillPopScope(
        onWillPop: () async {
          // Evitar que el usuario pueda regresar a la página anterior
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Buen día, José! ☀️', style: GoogleFonts.montserrat(),),
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
                    Text(
                      'Próximos a vencer', style: GoogleFonts.montserrat()
                    ),
                    const SizedBox(height: 20.0),
                    _buildCarousel(),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildDashboardButton(CupertinoIcons.clock, iconColor: Colors.black),
                        const SizedBox(width: 10.0),
                        _buildDashboardButton(CupertinoIcons.rocket, iconColor: Colors.black),
                        const SizedBox(width: 10.0),
                        _buildDashboardButton(CupertinoIcons.check_mark_circled, iconColor: Colors.black),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildDashboardButton(CupertinoIcons.arrow_down, iconColor: Colors.black),
                        const SizedBox(width: 10.0),
                        _buildDashboardButton(CupertinoIcons.arrow_up, iconColor: Colors.black),
                        const SizedBox(width: 10.0),
                        _buildDashboardButton(CupertinoIcons.snow, iconColor: Colors.black),
                      ],
                    ),
                    const SizedBox(height: 5.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSemaphoreButton(0),
                        const SizedBox(width: 10.0),
                        _buildSemaphoreButton(1),
                        const SizedBox(width: 10.0),
                        _buildSemaphoreButton(2),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildDashboardButton(CupertinoIcons.exclamationmark, iconColor: Colors.black),
                        const SizedBox(width: 10.0),
                        _buildDashboardButton(CupertinoIcons.hammer, iconColor: Colors.black),
                      ],
                    ),
                  ],
                ),
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
          _buildCard('Suministro 567', Colors.redAccent),
          _buildCard('Suministro 756', Colors.redAccent),
          _buildCard('Suministro 456', Colors.redAccent),
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
              style: GoogleFonts.montserrat(color: Colors.white), // Aplica el estilo a la tarjeta
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
        iconColor = Colors.redAccent;
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
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 10, // Ajusta el valor de elevación según sea necesario
        ),
      ),
    );
  }


  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      // Ajusta la propiedad width para reducir el área horizontal
      width: 200, // Puedes ajustar este valor según tus necesidades
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 100, // Ajusta la altura según tus necesidades
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
            title: Text('Perfil', style: GoogleFonts.montserrat()),
            onTap: () {
              // Agregar lógica para la opción 1 del menú
            },
          ),
          ListTile(
            title: Text('Contacto', style: GoogleFonts.montserrat()),
            onTap: () {
              // Agregar lógica para la opción 2 del menú
            },
          ),
          ListTile(
            title: Text('Cerrar sesión', style: GoogleFonts.montserrat()),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}




