/*
To use auto export feature, you just need to add the @AutoExporter()
annotation to your class that you want to be automatically exported
in the lib/auto_export.dart file.
Then in your other files, you just need to import the auto_export.dart
file to have access to all auto exported files
 */
import 'package:equatable/equatable.dart';
import 'package:todo_app/blocs/todos/model/filteredtodo/visibility_filter.dart';
import 'package:todo_app/blocs/todos/model/todo/Todo.dart';

/*
We're going to implement two events for our FilteredTodosBloc:
FilterUpdated - which notifies the bloc that the visibility filter has changed
TodosUpdated - which notifies the bloc that the list of todos has changed
 */

abstract class FilteredTodosEvent extends Equatable {
  const FilteredTodosEvent();
}

class FilterUpdated extends FilteredTodosEvent {
  final VisibilityFilter filter;

  const FilterUpdated(this.filter);

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'FilterUpdated { filter: $filter }';
}

class TodosUpdated extends FilteredTodosEvent {
  final List<Todo> todos;

  const TodosUpdated(this.todos);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodosUpdated { todos: $todos }';
}
