import 'package:crowfunding_project/core/controllers/session_manager.dart';
import 'package:get/get.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SessionManager(), permanent: true);
  }
}
