part of actions;

@freezed
class CreateUser with _$CreateUser {
  const factory CreateUser({
    required String email,
    required String password,
    required ActionResponse action,
  }) = CreateUserStart;

  const factory CreateUser.successful(User user) = CreateUserSuccessful;

  const factory CreateUser.error(Object error, StackTrace stackTrace) = CreateUserError;
}
