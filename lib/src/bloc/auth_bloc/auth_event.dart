import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable{

  @override
  List<Object> get props =>[];
}

class AuthRequested extends AuthEvent{
  final context;
  String username;
  String? fullname;
  String password;


  AuthRequested({required this.context,required this.username,required this.password,String? fullname}):this.fullname = fullname;
}

class AuthObscurePassword extends AuthEvent{
  bool isObscure;

  AuthObscurePassword({required this.isObscure});
}

class AuthModeChanged extends AuthEvent{}

