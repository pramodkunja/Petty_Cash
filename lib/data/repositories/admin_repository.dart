import 'package:dio/dio.dart';
import '../../core/services/network_service.dart';

class AdminRepository {
  final NetworkService _networkService;

  AdminRepository(this._networkService);

  Future<List<Map<String, dynamic>>> getOrgExpenses({String? status, String? paymentStatus}) async {
    try {
      final Map<String, dynamic> queryParams = {};
      if (status != null) queryParams['status'] = status;
      if (paymentStatus != null) queryParams['payment_status'] = paymentStatus;

      final response = await _networkService.get(
        '/approver/org-expenses',
        queryParameters: queryParams,
      );

      if (response.data is List) {
        return List<Map<String, dynamic>>.from(response.data);
      }
      return [];
    } catch (e) {
      print("Error fetching org expenses: $e");
      rethrow; // Or return empty list based on error handling policy
    }
  }
  Future<void> approveRequest(String requestId) async {
    try {
      await _networkService.post(
        '/approver/approve', 
        data: {'request_id': requestId}
      );
    } catch (e) {
      print("Error approving request: $e");
      rethrow;
    }
  }

  Future<void> rejectRequest(String requestId, String reason) async {
    try {
      await _networkService.post(
        '/approver/reject', 
        data: {'request_id': requestId, 'rejection_reason': reason}
      );
    } catch (e) {
      print("Error rejecting request: $e");
      rethrow;
    }
  }

  Future<void> askClarification(int id, String message) async {
    try {
     
      
      await _networkService.post(
        '/approver/ask-clarification', 
        data: {'expense_id': id, 'question': message}
      );
    } catch (e) {
      print("Error asking clarification: $e");
      rethrow;
    }
  }
}
