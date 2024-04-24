import 'package:get/get.dart';
import 'package:quize_app/Controller/quize_controller.dart';


class BilndingsApp implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuizController());
  }
}