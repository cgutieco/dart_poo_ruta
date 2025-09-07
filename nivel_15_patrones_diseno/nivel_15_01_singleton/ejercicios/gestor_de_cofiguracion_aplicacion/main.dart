import 'entities/app_settings.dart';
import 'entities/settings_display.dart';

void main(){
  final appSettings = AppSettings();

  final settingsDisplay = SettingsDisplay(appSettings: appSettings);

  settingsDisplay.displayCurrentSettings();

  appSettings.setTheme(newTheme: "light");

  settingsDisplay.displayCurrentSettings();
}