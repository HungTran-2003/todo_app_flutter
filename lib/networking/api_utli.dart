import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/networking/api_client.dart';

class ApiUtil {
  static ApiClient get apiClient => ApiClient(Supabase.instance.client);
}
