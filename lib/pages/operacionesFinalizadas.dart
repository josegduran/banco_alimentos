// Import necessary libraries
import 'package:banco_alimentos/pages/entradasFinalizadas.dart';
import 'package:banco_alimentos/pages/tareasFinalizadas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class OperacionesFinalizadasPage extends StatefulWidget {
  @override
  _OperacionesFinalizadasPageState createState() =>
      _OperacionesFinalizadasPageState();
}

class _OperacionesFinalizadasPageState
    extends State<OperacionesFinalizadasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Operaciones Finalizadas'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDashboardButton(
              CupertinoIcons.arrow_down,
              iconColor: Colors.black,
              onPressed: () {
                // Navigate to the TareasFinalizadasPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EntradasFinalizadasPage(),
                  ),
                );
              },
            ),
            const SizedBox(width: 10.0),
            _buildDashboardButton(
              CupertinoIcons.rocket,
              iconColor: Colors.black,
              onPressed: () {
                // Navigate to the EntregasFinalizadasPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TareasFinalizadasPage(),
                  ),
                );
              },
            ),
            const SizedBox(width: 10.0),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardButton(IconData icon, {Color? iconColor, VoidCallback? onPressed}) {
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
}
