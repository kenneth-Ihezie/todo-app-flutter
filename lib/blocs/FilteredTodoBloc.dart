/*
our FilteredTodosBloc will be similar to our TodosBloc
however, instead of having a dependency on the TodosRepository,
it will have a dependency on the TodosBloc itself.
This will allow the FilteredTodosBloc to update its
state in response to state changes in the TodosBloc.
*/
/*
  We create a StreamSubscription for the stream of TodosStates
  so that we can listen to the state changes in the TodosBloc.
  We override the bloc's close method and cancel the subscription
  so that we can clean up after the bloc is closed.
*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/blocs/todos/barrel/todo/todos.dart';
import 'package:todo_app/blocs/todos/events/filterdtodo/filtered_todos_event.dart';
import 'package:todo_app/blocs/todos/model/filteredtodo/visibility_filter.dart';
import 'package:todo_app/blocs/todos/model/todo/Todo.dart';
import 'package:todo_app/blocs/todos/state/filiteredtodo/filitered_todos_state.dart';
import 'TodoBloc.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final TodosBloc todosBloc;
  StreamSubscription todosSubscription;

  FilteredTodosBloc({@required this.todosBloc})
      : super(
    todosBloc.state is TodosLoadSuccessState
        ? FilteredTodosLoadSuccess(
      (todosBloc.state as TodosLoadSuccessState).todos,
      VisibilityFilter.ALL,
    )
        : FilteredTodosLoadInProgress(),
  ) {
    todosSubscription = todosBloc.listen((state) {
      if (state is TodosLoadSuccess) {
        add(TodosUpdated((todosBloc.state as TodosLoadSuccessState).todos));
      }
    });
  }

  @override
  Stream<FilteredTodosState> mapEventToState(FilteredTodosEvent event) async* {
    if (event is FilterUpdated) {
      yield* _mapUpdateFilterToState(event);
    } else if (event is TodosUpdated) {
      yield* _mapTodosUpdatedToState(event);
    }
  }

  Stream<FilteredTodosState> _mapUpdateFilterToState(
      FilterUpdated event,
      ) async* {
    if (todosBloc.state is TodosLoadSuccess) {
      yield FilteredTodosLoadSuccess(
        _mapTodosToFilteredTodos(
          (todosBloc.state as TodosLoadSuccessState).todos,
          event.filter,
        ),
        event.filter,
      );
    }
  }

  Stream<FilteredTodosState> _mapTodosUpdatedToState(
      TodosUpdated event,
      ) async* {
    final visibilityFilter = state is FilteredTodosLoadSuccess
        ? (state as FilteredTodosLoadSuccess).activeFilter
        : VisibilityFilter.ALL;
    yield FilteredTodosLoadSuccess(
      _mapTodosToFilteredTodos(
        (todosBloc.state as TodosLoadSuccessState).todos,
        visibilityFilter,
      ),
      visibilityFilter,
    );
  }

  List<Todo> _mapTodosToFilteredTodos(
      List<Todo> todos, VisibilityFilter filter) {
    return todos.where((todo) {
      if (filter == VisibilityFilter.ALL) {
        return true;
      } else if (filter == VisibilityFilter.ACTIVE) {
        return !todo.complete;
      } else {
        return todo.complete;
      }
    }).toList();
  }

  @override
  Future<void> close() {
    todosSubscription.cancel();
    return super.close();
  }
}



