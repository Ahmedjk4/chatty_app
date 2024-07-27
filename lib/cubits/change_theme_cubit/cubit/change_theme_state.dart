part of 'change_theme_cubit.dart';

@immutable
sealed class ChangeThemeState {
  Map<String, dynamic> toJson();
  static ChangeThemeState fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'LightMode':
        return LightMode();
      case 'DarkMode':
        return DarkMode();
      default:
        throw Exception('Unknown theme state');
    }
  }
}

class LightMode extends ChangeThemeState {
  @override
  Map<String, dynamic> toJson() => {'type': 'LightMode'};
}

class DarkMode extends ChangeThemeState {
  @override
  Map<String, dynamic> toJson() => {'type': 'DarkMode'};
}
