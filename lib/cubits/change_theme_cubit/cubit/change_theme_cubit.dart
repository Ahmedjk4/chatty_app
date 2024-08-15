import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
part 'change_theme_state.dart';

class ChangeThemeCubit extends HydratedCubit<ChangeThemeState> {
  ChangeThemeCubit() : super(LightMode());

  void changeTheme(int? themeIndex) {
    if (themeIndex == 0) {
      emit(LightMode());
    } else {
      emit(DarkMode());
    }
  }

  @override
  ChangeThemeState? fromJson(Map<String, dynamic> json) =>
      ChangeThemeState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(ChangeThemeState state) => state.toJson();
}
