import 'package:flutter/material.dart';
import 'pages/dashboard.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BAMX',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'BAMX'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          // Evitar que el usuario pueda regresar a la página anterior
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildImageGrid(),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the login page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text('Iniciar Sesión',
                      style: GoogleFonts.montserrat(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildImage('lib/assets/img/logoanahuac.png'),
        _buildImage('lib/assets/img/logoanahuac.png'),
        _buildImage('lib/assets/img/logoanahuac.png'),
        _buildImage('lib/assets/img/logoanahuac.png'),
        _buildImage('lib/assets/img/logoanahuac.png'),
        _buildImage('lib/assets/img/logoanahuac.png'),
      ],
    );
  }

  Widget _buildImage(String imagePath) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }

}



class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión', style: GoogleFonts.montserrat()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Image from assets
                Image.asset(
                  'lib/assets/img/bamx_logo.png',
                  height: 100.0, // Ajusta la altura según sea necesario
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Ingresa tus datos', style: GoogleFonts.montserrat()
                ),
                const SizedBox(height: 20.0),
                // Username TextField
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    border: OutlineInputBorder(),
                    labelStyle: GoogleFonts.montserrat(),
                  ),
                ),
                const SizedBox(height: 12.0),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                    labelStyle: GoogleFonts.montserrat(),
                  ),
                ),

                const SizedBox(height: 20.0),
                // Login Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardPage()),
                    );
                  },
                  child: Text('Acceder',
                      style: GoogleFonts.montserrat(color: Colors.black)),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // Agregar lógica para solicitar acceso
                  },
                  child: Text('Solicitar acceso',
                      style: GoogleFonts.montserrat(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

