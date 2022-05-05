/*
Our TabBloc will be responsible for handling a single TabEvent:
TabUpdated - which notifies the bloc that the active tab has updated
 */

import 'package:equatable/equatable.dart';
import 'package:todo_app/blocs/todos/model/tab/app_tab.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();
}

class TabUpdated extends TabEvent {
  final AppTab tab;

  const TabUpdated(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'TabUpdated { tab: $tab }';
}
