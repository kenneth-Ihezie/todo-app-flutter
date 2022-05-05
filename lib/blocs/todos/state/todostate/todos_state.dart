/*
Define the different states we will need to handle

The three states we will implement are:
TodosLoadInProgress - the state while our application is fetching todos from the repository.
TodosLoadSuccess - the state of our application after the todos have successfully been loaded.
TodosLoadFailure - the state of our application if the todos were not successfully loaded
 */

import 'package:equatable/equatable.dart';
import 'package:todo_app/blocs/todos/model/todo/Todo.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodosLoadInProgressState extends TodosState {}

class TodosLoadSuccessState extends TodosState {
  final List<Todo> todos;

  const TodosLoadSuccessState([this.todos = const []]);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodosLoadSuccess { todos: $todos }';
}

class TodosLoadFailureState extends TodosState {}
