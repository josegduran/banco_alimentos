class Entradas {
  static final String id = 'id';
  static final String numeroLote = 'numeroLote';
  static final String fechaRecepcion = 'fechaRecepcion';
  static final String proveedor = 'proveedor';
  static final String nombreProducto = 'nombreProducto';
  static final String cantidadRecibida = 'cantidadRecibida';
  static final String fechaFabricacion = 'fechaFabricacion';
  static final String fechaCaducidad = 'fechaCaducidad';
  static final String inspeccion = 'inspeccion';
  static final String ubicacionAlmacen = 'ubicacionAlmacen';
  static final String quienRegistro = 'quienRegistro';
  static final String estado = 'estado';
  static final String revisadoPor = 'revisadoPor';

  static List<String> getFields() => [id];
}

class EntradasPorVencer {
  String id;
  String numeroLote;
  String fechaRecepcion;
  String proveedor;
  String nombreProducto;
  String cantidadRecibida;
  String fechaFabricacion;
  String fechaCaducidad;
  String inspeccion;
  String ubicacionAlmacen;
  String quienRegistro;
  String estado;
  String revisadoPor;

  EntradasPorVencer({
    required this.id,
    required this.numeroLote,
    required this.fechaRecepcion,
    required this.proveedor,
    required this.nombreProducto,
    required this.cantidadRecibida,
    required this.fechaFabricacion,
    required this.fechaCaducidad,
    required this.inspeccion,
    required this.ubicacionAlmacen,
    required this.quienRegistro,
    required this.estado,
    required this.revisadoPor,
  });

  // Get the list of field names
  static List<String> getFields() => [
    'id',
    'numeroLote',
    'fechaRecepcion',
    'proveedor',
    'nombreProducto',
    'cantidadRecibida',
    'fechaFabricacion',
    'fechaCaducidad',
    'inspeccion',
    'ubicacionAlmacen',
    'quienRegistro',
    'estado',
    'revisadoPor',
  ];

  // Factory method to create an instance from a map
  factory EntradasPorVencer.fromMap(Map<String, dynamic> map) {
    return EntradasPorVencer(
      id: map['id'] ?? '',
      numeroLote: map['numeroLote'] ?? '',
      fechaRecepcion: map['fechaRecepcion'] ?? '',
      proveedor: map['proveedor'] ?? '',
      nombreProducto: map['nombreProducto'] ?? '',
      cantidadRecibida: map['cantidadRecibida'] ?? '',
      fechaFabricacion: map['fechaFabricacion'] ?? '',
      fechaCaducidad: map['fechaCaducidad'] ?? '',
      inspeccion: map['inspeccion'] ?? '',
      ubicacionAlmacen: map['ubicacionAlmacen'] ?? '',
      quienRegistro: map['quienRegistro'] ?? '',
      estado: map['estado'] ?? '',
      revisadoPor: map['revisadoPor'] ?? '',
    );
  }
}

