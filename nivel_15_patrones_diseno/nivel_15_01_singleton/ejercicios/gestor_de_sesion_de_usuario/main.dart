import 'entities/session_manager.dart';

void main() {
  final session1 = SessionManager();
  final session2 = SessionManager();

  print(identical(session1, session2));

  session1.login(userName: "usuario test 1", userId: "3221ksdad");

  print(session2.isLoggedIn);
  
  session1.logout();

  print(session2.isLoggedIn);
  print(session2.userName);
}
