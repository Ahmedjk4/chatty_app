part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

// ? Login
final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginError extends AuthState {
  final String error;

  LoginError({required this.error});
}

// ? Register
final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class RegisterError extends AuthState {
  final String error;

  RegisterError({required this.error});
}

// ? Logout
final class LogoutLoading extends AuthState {}

final class LogoutSuccess extends AuthState {}

final class LogoutError extends AuthState {
  final String error;

  LogoutError({required this.error});
}

// ? Update Name

final class UpdateNameLoading extends AuthState {}

final class UpdateNameSuccess extends AuthState {
  final String newName;

  UpdateNameSuccess({required this.newName});
}

final class UpdateNameError extends AuthState {
  final String error;

  UpdateNameError({required this.error});
}
