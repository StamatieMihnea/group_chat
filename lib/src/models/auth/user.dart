part of models;

@freezed
class User with _$User {
  const factory User({
    required String uid,
    required String email,
    required String displayName,
    String? imageUrl,
  }) = User$;

  factory User.fromJson(Map<dynamic, dynamic> json) => _$UserFromJson(Map<String, dynamic>.from(json));
}
