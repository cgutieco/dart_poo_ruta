import '../interfaces/IAppSettings.dart';

class SettingsDisplay {
  final IAppSettings _appSettings;

  SettingsDisplay({required IAppSettings appSettings})
    : _appSettings = appSettings;

  void displayCurrentSettings() {
    print(
      "Tema actual: ${_appSettings.theme}\nIdioma: ${_appSettings.languaje}"
    );
  }
}
