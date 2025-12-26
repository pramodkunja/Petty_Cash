import 'package:get/get.dart';

import '../controllers/requestor_controller.dart';
import '../controllers/my_requests_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class RequestorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RequestorController>(
      RequestorController(),
    );
    Get.put<MyRequestsController>(
      MyRequestsController(),
    );
     Get.put<ProfileController>(
      ProfileController(),
    );
  }
}
