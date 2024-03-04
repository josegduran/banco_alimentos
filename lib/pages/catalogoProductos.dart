// System
import 'package:flutter/material.dart';

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
        title: Text('Catalogo de Productos'),
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
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: displayedProducts.length,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      // Pass the selected product back to the previous page
                      Navigator.pop(context, displayedProducts[index]);
                    },
                    child: Center(
                      child: Text(displayedProducts[index].nombre),
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
}
