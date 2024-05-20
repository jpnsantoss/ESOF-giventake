import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_repository/product_repository.dart';
import 'package:request_repository/request_repository.dart';

void main() {
  group('Request model', () {
    test('toEntity() should return a RequestEntity with correct values', () {
      final request = Request(
        id: 'requestId',
        fromUserId: 'fromUserId',
        productId: 'productId',
        created_at: Timestamp.now(),
        accepted: false,
      );

      final requestEntity = request.toEntity();

      expect(requestEntity.id, request.id);
      expect(requestEntity.fromUserId, request.fromUserId);
      expect(requestEntity.productId, request.productId);
      expect(requestEntity.accepted, request.accepted);
      expect(requestEntity.created_at, request.created_at);
    });

    test('fromEntity() should return a Request with correct values', () {
      final requestEntity = RequestEntity(
        id: 'requestId',
        fromUserId: 'fromUserId',
        productId: 'productId',
        created_at: Timestamp.now(),
        accepted: false,
      );

      final request = Request.fromEntity(requestEntity);

      expect(request.id, requestEntity.id);
      expect(request.fromUserId, requestEntity.fromUserId);
      expect(request.productId, requestEntity.productId);
      expect(request.accepted, requestEntity.accepted);
      expect(request.created_at, requestEntity.created_at);
    });
  });
}
