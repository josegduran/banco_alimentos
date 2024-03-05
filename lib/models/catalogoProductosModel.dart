class Productos {
  String id;
  String nombre;
  String categoria;
  String prioridad;
  String imagen;
  String estado;

  Productos({
    required this.id,
    required this.nombre,
    required this.categoria,
    required this.prioridad,
    required this.imagen,
    required this.estado,
  });

  // Get the list of field names
  static List<String> getFields() =>
      ['id', 'nombre', 'categoria', 'prioridad', 'imagen', 'estado'];

  // Factory method to create an instance from a map
  factory Productos.fromMap(Map<String, dynamic> map) {
    return Productos(
      id: map['id'] ?? '',
      nombre: map['nombre'] ?? '',
      categoria: map['categoria'] ?? '',
      prioridad: map['prioridad'] ?? '',
      imagen: map['imagen'] ?? '',
      estado: map['estado'] ?? '',
    );
  }

  String constructImageUrl() {
    return 'https://drive.google.com/uc?export=view&id=$imagen';
  }
}
