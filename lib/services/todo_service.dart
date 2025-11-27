import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/models/entities/todo_entity.dart';

class TodoService{

  final _client = Supabase.instance.client;
  final _table = 'Todo';


  Future<List<TodoEntity>> getTodos() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return [];

    final data = await _client
        .from(_table)
        .select()
        .eq('user_id', userId)
        .order('dua_date', ascending: false);
    log(data.toString());
    return data.map<TodoEntity>((e) => TodoEntity.fromJson(e)).toList();
  }

  Future<TodoEntity?> createTodo(TodoEntity todo) async {
    log(todo.toJson().toString());
    final response = await _client
        .from(_table)
        .insert(todo.toJson())
        .select()
        .single();

    return TodoEntity.fromJson(response);
  }

  Future<TodoEntity?> updateTodo(TodoEntity todo) async {
    if (todo.id == null) return null;

    final response = await _client
        .from(_table)
        .update(todo.toJson())
        .eq('id', todo.id!)
        .select()
        .single();

    return TodoEntity.fromJson(response);
  }

  Future<bool> deleteTodo(int id) async {
    try {
      await _client.from(_table).delete().eq('id', id);
      return true;
    } catch (_) {
      return false;
    }
  }

}