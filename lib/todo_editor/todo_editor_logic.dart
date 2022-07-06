import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/data_class/todo_item.dart';
import 'package:todolist/todo_editor/todo_editor_events.dart';
import 'package:todolist/todo_editor/todo_editor_state.dart';

class TodoEditorLogic extends Bloc<TodoEditorEvent, TodoEditorState> {

  TodoEditorLogic(TodoItem? todoItem) : 
    super(TodoEditorState(
      mode: todoItem == null ? TodoEditorMode.creating : TodoEditorMode.editing,
      todoItem: todoItem ?? TodoItem.convenient(),
      savedTodoItem: todoItem
    )) {
    on<TextChangedInTodoEditor>(_onTextChangedInTodoEditor);
    on<PriorityChangedInTodoEditor>(_onPriorityChangedInTodoEditor);
    on<DeadlineChangedInTodoEditor>(_onDeadlineChangedInTodoEditor);
    on<TodoItemSavedInTodoEditor>(_onTodoItemSavedInTodoEditor);
    on<TodoItemDeletedInTodoEditor>(_onTodoItemDeletedInTodoEditor);
  }

  void _onTextChangedInTodoEditor(TextChangedInTodoEditor event, Emitter<TodoEditorState> emit) {
    emit(TodoEditorState(
      mode: state.mode,
      todoItem: state.todoItem.copyWith(text: event.text),
      savedTodoItem: state.savedTodoItem
    ));
  }

  void _onPriorityChangedInTodoEditor(PriorityChangedInTodoEditor event, Emitter<TodoEditorState> emit) {
    emit(TodoEditorState(
      mode: state.mode,
      todoItem: state.todoItem.copyWith(priority: event.priority),
      savedTodoItem: state.savedTodoItem
    ));   
  }

  void _onDeadlineChangedInTodoEditor(DeadlineChangedInTodoEditor event, Emitter<TodoEditorState> emit) {
    emit(TodoEditorState(
      mode: state.mode,
      todoItem: state.todoItem.copyWithOptional(deadline: event.deadline),
      savedTodoItem: state.savedTodoItem
    ));
  }

  void _onTodoItemSavedInTodoEditor(TodoItemSavedInTodoEditor event, Emitter<TodoEditorState> emit) {
    var nextTodoItemState = state.todoItem.copyWith(updatedAt: DateTime.now().microsecondsSinceEpoch);

    emit(TodoEditorState(
      mode: TodoEditorMode.editing,
      todoItem: nextTodoItemState,
      savedTodoItem: nextTodoItemState
    ));
  }

  void _onTodoItemDeletedInTodoEditor(TodoItemDeletedInTodoEditor event, Emitter<TodoEditorState> emit) {
    emit(TodoEditorState(
      mode: TodoEditorMode.creating,
      todoItem: TodoItem.convenient(),
      savedTodoItem: null
    ));
  }

  @override
  void onTransition(Transition<TodoEditorEvent, TodoEditorState> transition) {
    super.onTransition(transition);
    print('Bloc: ${transition.event.runtimeType}:'
        ' ${transition.currentState.todoItem.toJson()} -> ${transition.nextState.todoItem.toJson()}');
  }
}
