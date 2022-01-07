import 'package:get_storage/get_storage.dart';

class AppStorage {
  AppStorage._();

  static AppStorage appStorage = AppStorage._();
  var storage = GetStorage();

  static const FIRST_OPEN = 'first_open';
  static const TOKEN = 'token';

  Future<void> saveFirstOpen(bool firstOpen) async {
    return await storage.write(FIRST_OPEN, firstOpen);
  }

  bool getFirstOpen() {
    return storage.read(FIRST_OPEN) ?? false;
  }

  Future<void> saveToken(String? token) async {
    return await storage.write(TOKEN, token);
  }

  String? getToken() {
    return storage.read(TOKEN);
  }

  Future<void> removeToken() async {
    return await storage.remove(TOKEN);
  }
}
