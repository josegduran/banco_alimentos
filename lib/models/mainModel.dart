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
  static final String revisadoPor = 'revisadoPor';
  static final String fechaAceptacion = 'fechaAceptacion';
  static final String fechaFinalizacion = 'fechaFinalizacion';
  static final String motivoIncompleta = 'motivoIncompleta';

  static List<String> getFields() => [
    id,
    nombre,
    descripcion,
    fechaCreacion,
    fechaVencimiento,
    prioridad,
    estado,
    aceptadoPor,
    comentarios,
    creadoPor,
    revisadoPor,
    fechaAceptacion,
    fechaFinalizacion,
    motivoIncompleta
  ];
}
