import 'models/models.dart';
abstract class RequestRepo {
  Future<List<Request>> getRequests();
  Future<void> addRequest(Request request);
}