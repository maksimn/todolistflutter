import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/todo_list/todo_list_events.dart';
import 'package:todolist/todo_list/todo_list_state.dart';

class TodoListLogic extends Bloc<TodoListEvent, TodoListState> {

  TodoListLogic() : super(const TodoListState(items: [])) {
    on<InitialTodoListDataFetched>(_onInitialTodoListDataFetched);
    on<SavedTodoItem>(_onSavedTodoItem);
  }

  void _onInitialTodoListDataFetched(InitialTodoListDataFetched event, Emitter<TodoListState> emit) {
    emit(TodoListState(items: event.items));
  }

  void _onSavedTodoItem(SavedTodoItem event, Emitter<TodoListState> emit) {
    var index = state.items.indexWhere((element) => element.id == event.item.id);

    if (index < 0) {
      var newItems = state.items;

      newItems.add(event.item);
      emit(TodoListState(items: newItems));
    } else {
      state.items[index] = event.item;
      emit(TodoListState(items: state.items));
    }
  }
}
