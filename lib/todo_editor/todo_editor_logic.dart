import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/todo_editor/todo_editor_events.dart';
import 'package:todolist/todo_editor/todo_editor_state.dart';
import 'package:todolist/data_class/todo_item.dart';

class TodoEditorLogic extends Bloc<TodoEditorEvent, TodoEditorState> {

  TodoEditorLogic() : super(TodoEditorState(todoItem: TodoItem.convenient())) {
    on<TextChangedInTodoEditor>(_onTextChangedInTodoEditor);
    on<PriorityChangedInTodoEditor>(_onPriorityChangedInTodoEditor);
    on<DeadlineChangedInTodoEditor>(_onDeadlineChangedInTodoEditor);
  }

  void _onTextChangedInTodoEditor(TextChangedInTodoEditor event, Emitter<TodoEditorState> emit) {
    emit(
      TodoEditorState(
        todoItem: state.todoItem.copyWith(text: event.text)
      )
    );
  }

  void _onPriorityChangedInTodoEditor(PriorityChangedInTodoEditor event, Emitter<TodoEditorState> emit) {
    emit(
      TodoEditorState(
        todoItem: state.todoItem.copyWith(priority: event.priority)
      )
    );    
  }

  void _onDeadlineChangedInTodoEditor(DeadlineChangedInTodoEditor event, Emitter<TodoEditorState> emit) {
    emit(
      TodoEditorState(
        todoItem: state.todoItem.copyWithOptional(deadline: event.deadline)
      )
    );    
  }

  @override
  void onTransition(Transition<TodoEditorEvent, TodoEditorState> transition) {
    super.onTransition(transition);
    print('Bloc: ${transition.event.runtimeType}:'
        ' ${transition.currentState.todoItem.toJson()} -> ${transition.nextState.todoItem.toJson()}');
  }
}
