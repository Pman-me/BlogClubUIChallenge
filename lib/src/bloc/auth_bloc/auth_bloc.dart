import 'package:blog_club/src/bloc/auth_bloc/auth_event.dart';
import 'package:blog_club/src/bloc/auth_bloc/auth_state.dart';
import 'package:blog_club/src/configs/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late GlobalKey<FormState> formKey;

  AuthBloc() : super(AuthState(authMode: AuthMode.login, isLoading: false)) {
    formKey = GlobalKey();
    on<AuthObscurePassword>(_onObscurePassword);
    on<AuthModeChanged>(_onModeChanged);
    on<AuthRequested>(_onRequested);
  }

  _onRequested(AuthRequested event, Emitter<AuthState> emit) {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(isLoading: true));

      if (state.authMode == AuthMode.login) {
        //login request
      } else {
        //signup request
      }
      Future.delayed(const Duration(seconds: 2)).then((value) =>
          GoRouter.of(event.context).goNamed(AppRoutes.kHomeScreenRoute));
    }
  }

  _onObscurePassword(AuthObscurePassword event, Emitter<AuthState> emit) {
    emit(state.copyWith(isObscure: !event.isObscure));
  }

  _onModeChanged(AuthModeChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(
        authMode:
            state.authMode == AuthMode.login ? AuthMode.signup : AuthMode.login,
        isObscure: true));
  }
}
