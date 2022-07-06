import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/todo_list/todo_list_events.dart';
import 'package:todolist/todo_list/todo_list_state.dart';

class TodoListLogic extends Bloc<TodoListEvent, TodoListState> {

  TodoListLogic() : super(const TodoListState(items: [])) {
    on<InitialTodoListDataFetched>(_onInitialTodoListDataFetched);
  }

  void _onInitialTodoListDataFetched(InitialTodoListDataFetched event, Emitter<TodoListState> emit) {
    emit(TodoListState(items: event.items));
  }
}
