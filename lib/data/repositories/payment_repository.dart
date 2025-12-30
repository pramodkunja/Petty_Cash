import '../../core/services/network_service.dart';

class PaymentRepository {
  final NetworkService _networkService;

  PaymentRepository(this._networkService);

  Future<void> recordPayment({
    required double amount,
    required String method, // 'UPI', 'CASH', 'CUSTOM'
    String? transactionId,
    String? note,
  }) async {
    try {
      await _networkService.post(
        '/payments/record',
        data: {
          'amount': amount,
          'payment_method': method,
          'transaction_id': transactionId,
          'note': note,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getPaymentHistory() async {
    try {
      final response = await _networkService.get('/payments/history');
      if (response.data is List) {
        return (response.data as List).map((e) => e as Map<String, dynamic>).toList();
      }
      return [];
    } catch (e) {
      // Return empty list on error for now, or rethrow based on UI needs
      return [];
    }
  }
}
