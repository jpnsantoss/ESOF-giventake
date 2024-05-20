import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:user_repository/user_repository.dart';
import 'package:product_repository/product_repository.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('Product model', () {
    test('toEntity() should return a ProductEntity with correct values', () {
      final product = Product(
        id: 'productId',
        title: 'Test Product',
        description: 'Test description',
        location: 'Test location',
        image: 'https://example.com/image.png',
        userId: 'userId',
        createdAt: DateTime.now(),
        sold: false,
      );

      final productEntity = product.toEntity();

      expect(productEntity.id, product.id);
      expect(productEntity.title, product.title);
      expect(productEntity.description, product.description);
      expect(productEntity.location, product.location);
      expect(productEntity.image, product.image);
      expect(productEntity.userId, product.userId);
      expect(productEntity.createdAt, product.createdAt);
      expect(productEntity.sold, product.sold);
    });

    test('fromEntity() should return a Product with correct values', () {
      //sample product entity
      final productEntity = ProductEntity(
        id: 'productId',
        title: 'Test Product',
        description: 'Test description',
        location: 'Test location',
        image: 'https://example.com/image.png',
        userId: 'userId',
        createdAt: DateTime.now(),
        sold: false,
      );

      final product = Product.fromEntity(productEntity);

      expect(product.id, productEntity.id);
      expect(product.title, productEntity.title);
      expect(product.description, productEntity.description);
      expect(product.location, productEntity.location);
      expect(product.image, productEntity.image);
      expect(product.userId, productEntity.userId);
      expect(product.createdAt, productEntity.createdAt);
      expect(product.sold, productEntity.sold);
    });
  });
}
