import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    onLoginEvent();
    onRegistereEvent();
    onLogoutEvent();
    onUpdateNameEvent();
  }

  void onRegistereEvent() {
    on<RegisterEvent>(
      (event, emit) async {
        emit(RegisterLoading());
        try {
          await AuthService.signUp(
              name: event.name, email: event.email, password: event.password);
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'network-request-failed') {
            emit(RegisterError(
                error:
                    'Network error. Please check your internet connection.'));
          }
          if (e.code == 'weak-password') {
            emit(RegisterError(error: 'The password provided is too weak.'));
          }
          if (e.code == 'email-already-in-use') {
            emit(RegisterError(
                error: 'The account already exists for that email.'));
          } else {
            emit(RegisterError(error: 'Unkown Signup error: ${e.message}'));
          }
        } on SocketException {
          emit(RegisterError(
              error: 'Network error. Please check your internet connection.'));
        } catch (e) {
          emit(RegisterError(
              error: 'Unexpected error. Please try again later. \n'
                  'Error: ${e.toString()}'));
        }
      },
    );
  }

  void onLoginEvent() {
    on<LoginEvent>(
      (event, emit) async {
        emit(LoginLoading());
        try {
          await AuthService.signIn(
              email: event.email, password: event.password);

          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginError(error: 'User not found'));
          } else if (e.code == 'wrong-password') {
            emit(LoginError(error: 'Wrong password provided for that user.'));
          } else if (e.code == 'invalid-credential') {
            emit(LoginError(error: 'Invalid email or password.'));
          } else if (e.code == 'network-request-failed') {
            emit(LoginError(
                error:
                    'Network error. Please check your internet connection.'));
          } else {
            emit(LoginError(error: 'Authentication error: ${e.message}'));
          }
        } on SocketException {
          emit(LoginError(
              error: 'Network error. Please check your internet connection.'));
        } catch (e) {
          emit(LoginError(
              error:
                  'Unexpected error. Please try again later. \nError: ${e.toString()}'));
        }
      },
    );
  }

  void onLogoutEvent() {
    on<LogoutEvent>((event, emit) async {
      emit(LogoutLoading());
      try {
        await AuthService.logOut();
        emit(LogoutSuccess());
      } catch (e) {
        emit(LogoutError(error: 'Logout error: ${e.toString()}'));
      }
    });
  }

  void onUpdateNameEvent() {
    on<UpdateNameEvent>((event, emit) async {
      emit(UpdateNameLoading());
      try {
        await AuthService.updateName(event.name);
        emit(UpdateNameSuccess(newName: event.name));
      } catch (e) {
        emit(UpdateNameError(error: e.toString()));
      }
    });
  }
}
