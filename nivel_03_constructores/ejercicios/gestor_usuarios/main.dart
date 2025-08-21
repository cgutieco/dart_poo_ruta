import 'entities/usuario.dart';

void main() {
  Usuario usuario1 = Usuario(nombre: "César", rol: ROL.admin);
  Usuario usuario3 = Usuario(nombre: "Julio", rol: ROL.admin);
  Usuario usuario2 = Usuario(nombre: "César", rol: ROL.invitado);

  List<Usuario> usuarios = [usuario1, usuario2];

  usuarios.forEach((usuario) => usuario.saludar());

  print(identical(usuario1, usuario3));
  print(identical(usuario1, usuario2));
}
