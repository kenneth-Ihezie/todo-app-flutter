import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:todo_app/blocs/todos/events/tab/tab_event.dart';
import 'package:todo_app/blocs/todos/model/tab/app_tab.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.TODOS);

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is TabUpdated) {
      yield event.tab;
    }
  }
}
