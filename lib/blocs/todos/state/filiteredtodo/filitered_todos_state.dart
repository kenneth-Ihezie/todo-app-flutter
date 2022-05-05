/*
We will only have two states
FilteredTodosLoadInProgress - the state while we are fetching todos
FilteredTodosLoadSuccess - the state when we are no longer fetching todos
*/
/*
Note: The FilteredTodoLoadSuccess state contains the list
of filtered todos as well as the active visibility filter.
*/

import 'package:equatable/equatable.dart';
import 'package:todo_app/blocs/todos/model/filteredtodo/visibility_filter.dart';
import 'package:todo_app/blocs/todos/model/todo/Todo.dart';

abstract class FilteredTodosState extends Equatable {
  const FilteredTodosState();

  @override
  List<Object> get props => [];
}

class FilteredTodosLoadInProgress extends FilteredTodosState {}

class FilteredTodosLoadSuccess extends FilteredTodosState {
  final List<Todo> filteredTodos;
  final VisibilityFilter activeFilter;

  const FilteredTodosLoadSuccess(
      this.filteredTodos,
      this.activeFilter,
      );

  @override
  List<Object> get props => [filteredTodos, activeFilter];

  @override
  String toString() {
    return 'FilteredTodosLoadSuccess { filteredTodos: $filteredTodos, activeFilter: $activeFilter }';
  }
}

