import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../data/repositories/request_repository.dart';
import '../../../../core/services/network_service.dart';
import '../../../../routes/app_routes.dart';

class ProvideClarificationController extends GetxController {
  late final RequestRepository _requestRepository;
  final request = {}.obs;
  final responseController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _requestRepository = RequestRepository(Get.find<NetworkService>());
    if (Get.arguments != null) {
      request.value = Get.arguments;
    }
  }

  @override
  void onClose() {
    responseController.dispose();
    super.onClose();
  }

  Future<void> submitClarification() async {
    if (responseController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please enter your explanation");
      return;
    }

    try {
      isLoading.value = true;
      final id = request['id']; // Ensure we use numeric ID
      if (id == null) {
        Get.snackbar("Error", "Invalid Request ID");
        return;
      }
      
      // Call repository method
       await _requestRepository.submitClarification(id is int ? id : int.parse(id.toString()), responseController.text.trim());
      
      Get.back();
      Get.snackbar("Success", "Clarification submitted successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to submit: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
