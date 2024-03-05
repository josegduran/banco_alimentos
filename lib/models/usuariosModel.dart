class Usuarios {
  static final String idField = 'id';
  static final String nombreField = 'nombre';
  static final String apellidoPaternoField = 'apellidoPaterno';
  static final String apellidoMaternoField = 'apellidoMaterno';
  static final String nombreApellidoField = 'nombreApellido';
  static final String telefonoField = 'telefono';
  static final String fechaNacimientoField = 'fechaNacimiento';
  static final String direccionField = 'direccion';
  static final String usuarioField = 'usuario';
  static final String passwordField = 'password';
  static final String rolField = 'rol';
  static final String fotoPerfilField = 'fotoPerfil';
  static final String estadoField = 'estado';

  static List<String> getFields() => [
        idField,
        nombreField,
        apellidoPaternoField,
        apellidoMaternoField,
        nombreApellidoField,
        telefonoField,
        fechaNacimientoField,
        direccionField,
        usuarioField,
        passwordField,
        rolField,
        fotoPerfilField,
        estadoField
      ];

  String? id;
  String? nombre;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? nombreApellido;
  String? telefono;
  String? fechaNacimiento;
  String? direccion;
  String? usuario;
  String? password;
  String? rol;
  String? fotoPerfil;
  String? estado;

  // Constructor
  Usuarios(
      {this.id,
      this.nombre,
      this.apellidoPaterno,
      this.apellidoMaterno,
      this.nombreApellido,
      this.telefono,
      this.fechaNacimiento,
      this.direccion,
      this.usuario,
      this.password,
      this.rol,
      this.fotoPerfil,
      this.estado});

  // Método para crear una instancia de Proveedores desde un mapa
  static Usuarios fromMap(Map<String, dynamic> map) {
    return Usuarios(
      id: map[idField],
      nombre: map[nombreField],
      apellidoPaterno: map[apellidoPaternoField],
      apellidoMaterno: map[apellidoMaternoField],
      nombreApellido: map[nombreApellidoField],
      telefono: map[telefonoField],
      fechaNacimiento: map[fechaNacimientoField],
      direccion: map[direccionField],
      usuario: map[usuarioField],
      password: map[passwordField],
      rol: map[rolField],
      fotoPerfil: map[fotoPerfilField],
      estado: map[estadoField]
    );
  }
}
