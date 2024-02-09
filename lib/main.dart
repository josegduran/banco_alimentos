import 'package:flutter/material.dart';
import 'pages/dashboard.dart';

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
          padding: const EdgeInsets.only(bottom: 60.0), // Agrega un margen al fondo
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildImageGrid(), // Agrega la cuadrícula de imágenes
                Spacer(), // Espaciador flexible que empujará el botón hacia abajo
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the login page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: const Text('Iniciar Sesión'),
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
      physics: NeverScrollableScrollPhysics(), // Evita el desplazamiento del GridView
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
        title: const Text('Iniciar Sesión'),
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
                  height: 100.0, // Adjust the height as needed
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'Ingresa tus datos',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                // Username TextField
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12.0),
                // Password TextField
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
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
                  child: const Text('Acceder'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add logic for requesting access
                  },
                  child: const Text('Solicitar acceso'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
