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
          automaticallyImplyLeading: false, // Elimina el botón de retroceso
          // title: const Text('Dashboard'), // Comenta o elimina esta línea
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Bienvenido de nuevo, José! :)',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                // Placeholder widgets for dashboard content
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
                    _buildDashboardButton(CupertinoIcons.lightbulb_fill),
                    _buildDashboardButton(CupertinoIcons.arrow_up),
                    _buildDashboardButton(CupertinoIcons.snow),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardButton(IconData icon) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () {
          // Agregar lógica para el ítem correspondiente del panel de control
        },
        icon: Icon(icon),
        label: SizedBox.shrink(), // Eliminar la etiqueta (texto)
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}
