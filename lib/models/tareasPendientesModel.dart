class UserFields {
  static final String id = 'id';
  static final String nombre = 'nombre';
  static final String descripcion = 'descripcion';
  static final String fechaCreacion = 'fechaCreacion';
  static final String fechaVencimiento = 'fechaVencimiento';
  static final String prioridad = 'prioridad';
  static final String estado = 'estado';
  static final String aceptadoPor = 'aceptadoPor';
  static final String comentarios = 'comentarios';
  static final String creadoPor = 'creadoPor';

  static List<String> getFields() => [id, nombre, descripcion, fechaCreacion,
    fechaVencimiento, prioridad, estado, aceptadoPor, comentarios, creadoPor];
}
