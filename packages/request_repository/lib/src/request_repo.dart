import 'models/models.dart';
abstract class RequestRepo {
  Future<List<Request>> getRequests();
  Future<void> addRequest(Request request);
  Future<void> acceptRequest(String requestId);
  Future<void> rejectRequest(String requestId);
}