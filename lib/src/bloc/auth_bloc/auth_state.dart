import 'package:equatable/equatable.dart';

enum AuthMode { login, signup }

class AuthState extends Equatable {
  late final AuthMode authMode;
  late bool isObscure;
  late bool isLoading;

  AuthState(
      {required this.authMode, bool isObscure = true, bool isLoading = false})
      : this.isObscure = isObscure,
        this.isLoading = isLoading;

  AuthState copyWith({AuthMode? authMode, bool? isObscure, bool? isLoading}) {
    return AuthState(
        authMode: authMode ?? this.authMode,
        isObscure: isObscure ?? this.isObscure,
        isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object> get props => [authMode, isObscure];
}
