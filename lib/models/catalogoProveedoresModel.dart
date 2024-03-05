class Proveedores {
  static final String idField = 'id';
  static final String nombreField = 'nombre';
  static final String estadoField = 'estado';

  static List<String> getFields() => [
    idField,
    nombreField,
    estadoField,
  ];

  String? id;
  String? nombre;
  String? estado;

  // Constructor
  Proveedores({this.id, this.nombre, this.estado});

  // Método para crear una instancia de Proveedores desde un mapa
  static Proveedores fromMap(Map<String, dynamic> map) {
    return Proveedores(
      id: map[idField],
      nombre: map[nombreField],
      estado: map[estadoField],
    );
  }
}