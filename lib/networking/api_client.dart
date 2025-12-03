import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/models/entities/todo_entity.dart';

class ApiClient {
  final SupabaseClient _supabaseClient;
  final _table = 'Todo';

  ApiClient(this._supabaseClient);

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String udid,
  }) async {
    return await _supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: {"device_id": udid},
    );
  }

  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> refreshSession(String token) async {
    return await _supabaseClient.auth.refreshSession(token);
  }

  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  Future<List<TodoEntity>> getTodos() async {
    final userId = _supabaseClient.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('User not authenticated');
    }
    final data = await _supabaseClient
        .from(_table)
        .select()
        .eq('user_id', userId)
        .order('dua_date', ascending: false);
    log(data.toString());
    return data.map<TodoEntity>((e) => TodoEntity.fromJson(e)).toList();
  }

  Future<TodoEntity?> createTodo(TodoEntity todo) async {
    final response = await _supabaseClient
        .from(_table)
        .insert(todo.toJson())
        .select()
        .single();
    log(response.toString());
    return TodoEntity.fromJson(response);
  }

  Future<TodoEntity?> updateTodo(TodoEntity todo) async {
    final response = await _supabaseClient
        .from(_table)
        .update(todo.toJson())
        .eq('id', todo.id!)
        .select()
        .single();
    return TodoEntity.fromJson(response);
  }

  Future<void> deleteTodo(int id) async {
    await _supabaseClient.from(_table).delete().eq('id', id);
  }
}
