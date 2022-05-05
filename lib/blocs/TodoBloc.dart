/*
Now that we have our TodosStates and TodosEvents implemented
we can implement our TodosBloc.
 */
/*
To use auto export feature, you just need to add the @AutoExporter()
annotation to your class that you want to be automatically exported
in the lib/auto_export.dart file.
Then in your other files, you just need to import the auto_export.dart
file to have access to all auto exported files
 */
/*
  Our TodosBloc will have a dependency on the TodosRepository
  so that it can load and save todos. It will have an initial
  state of TodosLoadInProgress and defines the private handlers
  for each of the events. Whenever the TodosBloc changes the list
  of todos it calls the saveTodos method in the TodosRepository
  in order to keep everything persisted locally.
 */
//Here the state controls the event being called.
/*
  When we yield a state in the private mapEventToState handlers,
  we are always yielding a new state instead of mutating the state.
  This is because every time we yield, bloc will compare the
  state to the nextState and will only trigger a state change
  (transition) if the two states are not equal.
  If we just mutate and yield the same instance of state,
  then state == nextState would evaluate to true and no state
  change would occur.
 */
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todos_repository_simple/todos_repository_simple.dart';
import 'package:todo_app/blocs/todos/model/todo/Todo.dart';
import 'todos/events/todoevent/TodoEvent.dart';
import 'todos/state/todostate/todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepositoryFlutter todosRepository;

  TodosBloc({@required this.todosRepository}) : super(TodosLoadInProgressState());

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is TodosLoadSuccess) {
      yield* _mapTodosLoadedToState();
    } else if (event is TodoAdded) {
      yield* _mapTodoAddedToState(event);
    } else if (event is TodoUpdated) {
      yield* _mapTodoUpdatedToState(event);
    } else if (event is TodoDeleted) {
      yield* _mapTodoDeletedToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    }
  }

  Stream<TodosState> _mapTodosLoadedToState() async* {
    try {
      final todos = await this.todosRepository.loadTodos();
      yield TodosLoadSuccessState(
        todos.map(Todo.fromEntity).toList(),
      );
    } catch (_) {
      yield TodosLoadFailureState();
    }
  }

  Stream<TodosState> _mapTodoAddedToState(TodoAdded event) async* {
    if (state is TodosLoadSuccessState) {
      final List<Todo> updatedTodos = List.from((state as TodosLoadSuccessState).todos)
        ..add(event.todo);
      yield TodosLoadSuccessState(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapTodoUpdatedToState(TodoUpdated event) async* {
    if (state is TodosLoadSuccessState) {
      final List<Todo> updatedTodos = (state as TodosLoadSuccessState).todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();
      yield TodosLoadSuccessState(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapTodoDeletedToState(TodoDeleted event) async* {
    if (state is TodosLoadSuccessState) {
      final updatedTodos = (state as TodosLoadSuccessState)
          .todos
          .where((todo) => todo.id != event.todo.id)
          .toList();
      yield TodosLoadSuccessState(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapToggleAllToState() async* {
    if (state is TodosLoadSuccessState) {
      final allComplete =
      (state as TodosLoadSuccessState).todos.every((todo) => todo.complete);
      final List<Todo> updatedTodos = (state as TodosLoadSuccessState)
          .todos
          .map((todo) => todo.copyWith(complete: !allComplete))
          .toList();
      yield TodosLoadSuccessState(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapClearCompletedToState() async* {
    if (state is TodosLoadSuccessState) {
      final List<Todo> updatedTodos =
      (state as TodosLoadSuccessState).todos.where((todo) => !todo.complete).toList();
      yield TodosLoadSuccessState(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Future _saveTodos(List<Todo> todos) {
    return todosRepository.saveTodos(
      todos.map((todo) => todo.toEntity()).toList(),
    );
  }
}
