class UserFields {
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

  static List<String> getFields() => [
    id,
    numeroLote,
    fechaRecepcion,
    proveedor,
    nombreProducto,
    cantidadRecibida,
    fechaFabricacion,
    fechaCaducidad,
    inspeccion,
    ubicacionAlmacen,
    quienRegistro,
    estado,
    revisadoPor,
  ];
}
