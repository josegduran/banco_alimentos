import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

// Controllers
import 'package:banco_alimentos/controllers/catalogoProductosController.dart';

// Models
import 'package:banco_alimentos/models/catalogoProductosModel.dart';

class CatalogoProductosPage extends StatefulWidget {
  @override
  _CatalogoProductosPageState createState() => _CatalogoProductosPageState();
}

class _CatalogoProductosPageState extends State<CatalogoProductosPage> {
  List<Productos> allProducts = [];
  List<Productos> displayedProducts = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    await catalogoProductosController.init(); // Initialize Google Drive API
    final products = await catalogoProductosController.readAllRows();
    setState(() {
      allProducts = products;
      displayedProducts = products;
    });
  }

  void _filterProducts(String query) {
    query = query.toLowerCase();
    setState(() {
      displayedProducts = allProducts
          .where((product) => product.nombre.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Productos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: _filterProducts,
              decoration: InputDecoration(
                labelText: 'Buscar Producto',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedProducts.length,
              itemBuilder: (context, index) {
                return Card(
                  child: // En la clase _CatalogoProductosPageState
                  InkWell(
                    onTap: () {
                      // Pasar el producto seleccionado de vuelta a la página anterior
                      Navigator.pop(context, displayedProducts[index]);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder<Uint8List>(
                          future: _getImage(displayedProducts[index].constructImageUrl()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error al cargar la imagen');
                            } else {
                              return Image.network(
                                'https://drive.google.com/uc?export=view&id=${displayedProducts[index].imagen}',
                                fit: BoxFit.cover,
                              );
                            }
                          },
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          displayedProducts[index].nombre,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                );
              },
            ),
          ),
        ],
      ),
    );
  }



  Future<Uint8List> _getImage(String url) async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print('Error al cargar la imagen. Código de estado: ${response.statusCode}');
        return Uint8List(0); // Otra opción es lanzar una excepción
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
      return Uint8List(0); // Otra opción es lanzar una excepción
    }
  }
}
