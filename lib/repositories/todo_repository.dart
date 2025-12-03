import 'package:todo_app/models/entities/todo_entity.dart';
import 'package:todo_app/networking/api_client.dart';

abstract class TodoRepository {
  Future<List<TodoEntity>> getTodos();

  Future<TodoEntity?> createTodo(TodoEntity todo);

  Future<TodoEntity?> updateTodo(TodoEntity todo);

  Future<bool> deleteTodo(int id);
}

class TodoRepositoryImpl extends TodoRepository {
  final ApiClient _apiClient;

  TodoRepositoryImpl(this._apiClient);

  @override
  Future<TodoEntity?> createTodo(TodoEntity todo) async {
    return await _apiClient.createTodo(todo);
  }

  @override
  Future<bool> deleteTodo(int id) async {
    await _apiClient.deleteTodo(id);
    return true;
  }

  @override
  Future<List<TodoEntity>> getTodos() async {
    return await _apiClient.getTodos();
  }

  @override
  Future<TodoEntity?> updateTodo(TodoEntity todo) async {
    return await _apiClient.updateTodo(todo);
  }
}
