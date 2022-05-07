import 'package:blog_club/src/core/constants/general_constants.dart';

String? passwordValidator(String? value){
  if(value!.isEmpty) return 'required';
  if(value.length<10) {
    return 'cannot be less than 10 letters';
  } else {
    return null;
  }
}

String? nameValidator(String? value){
  if(value!.isEmpty) {
    return 'required';
  } else {
    return null;
  }

}

String? emailValidator(String? value){
  if(value!.isEmpty) return 'required';
  if(!emailRegex.hasMatch(value)) {
    return 'email address is invalid';
  } else {
    return null;
  }
}