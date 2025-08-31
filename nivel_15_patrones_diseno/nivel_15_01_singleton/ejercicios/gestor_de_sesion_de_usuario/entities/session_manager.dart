// final para que la clase no sea extendida ni implementada
final class SessionManager {
  String? _userName;
  String? _userId;
  DateTime? _loginTime;

  // Esto va a guardar la única instancia de mi clase
  static final _instance = SessionManager._();

  // Constructor privado, impide crear nuevas instancias
  SessionManager._();

  // No crea una nueva instancia
  factory SessionManager() => _instance;

  DateTime? get loginTime => _loginTime;

  String? get userId => _userId;

  String? get userName => _userName;

  void login({required String userName, required String userId}) {
    this._userName = userName;
    this._userId = userId;
    this._loginTime = DateTime.now();
  }

  void logout() {
    this._userName = null;
    this._userId = null;
    this._loginTime = null;
  }

  bool get isLoggedIn => _userName != null;
}
