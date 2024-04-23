import 'package:request_repository/src/models/request.dart';

abstract class RequestRepo {
  Future<void> addRequest(Request request);
  Future<List<Request>> getRequests();

}
