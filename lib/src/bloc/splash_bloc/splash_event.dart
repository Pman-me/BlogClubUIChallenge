import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SplashEvent extends Equatable{

  @override
  List<Object> get props =>[];
}


class NavigateToEvent extends SplashEvent{
  BuildContext context;

  NavigateToEvent({required this.context});
}