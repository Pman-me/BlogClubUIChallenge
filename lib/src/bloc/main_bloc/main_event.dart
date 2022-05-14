import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable{

  @override
  List<Object> get props =>[];
}

class MainNavigateTo extends MainEvent{
  int currentScreenIndex;

  MainNavigateTo({required this.currentScreenIndex});
}
class MainBackTo extends MainEvent{
  int currentScreenIndex;

  MainBackTo({required this.currentScreenIndex});
}