part of models;

@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(AuthState()) AuthState authState,
  }) = AppState$;

  factory AppState.fromJson(Map<dynamic, dynamic> json) =>
      _$AppStateFromJson(Map<String, dynamic>.from(json));
}
