import 'package:blog_club/src/bloc/main_bloc/main_event.dart';
import 'package:blog_club/src/bloc/main_bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainBloc extends Bloc<MainEvent, MainState> {


  MainBloc() : super(MainState(currentScreenIndex: 0)) {
    on<MainNavigateTo>(_onNavigateTo);
    on<MainBackTo>(_onBackTo);
  }

  _onNavigateTo(MainNavigateTo event, Emitter<MainState> emit) {
    state.screensHistory.add(state.currentScreenIndex);
    emit(state.copyWith(currentScreenIndex: event.currentScreenIndex));
  }

   _onBackTo(MainBackTo event, Emitter<MainState> emit) {
     state.screensHistory.remove(state.screensHistory.last);
     emit(state.copyWith(currentScreenIndex: event.currentScreenIndex));
   }
}
