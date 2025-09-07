import '../interfaces/IAppSettings.dart';

final class AppSettings implements IAppSettings {
  String _theme = "dark";
  String _languaje = "spanish";
  static final _instance = AppSettings._();

  AppSettings._();

  factory AppSettings() => _instance;

  @override
  String get languaje => _languaje;

  @override
  String get theme => _theme;

  @override
  void setTheme({required String newTheme}) {
    _theme = newTheme;
  }
}