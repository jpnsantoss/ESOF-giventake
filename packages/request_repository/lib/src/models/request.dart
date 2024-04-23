import 'package:request_repository/src/entities/request_entity.dart';
import 'package:user_repository/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../entities/entities.dart';

class Request {
  final String id;
  final String fromUserId;
  final String productId;
  String requesterId;

  bool accepted = false;
  MyUser? user;

  Request({
    required this.fromUserId,
    this.id = '',
    required this.productId,
    required this.requesterId,
    this.accepted = false,
  });

  Future<void> fetchFromUser(UserRepository userRepository) async {
    user = await userRepository.getUser(fromUserId);
  }

  /*
  Future<void> fetchReceiver(UserRepository userRepository) async {
    user = await userRepository.getUser(requesterId);
  }*/

  factory Request.fromQuery(String fromUserId, String productId) {
    return Request(
      fromUserId: fromUserId,
      productId: productId,
      requesterId: '',
    );
  }

  static Future<Request> createWithRequesterId(String fromUserId, String productId) async {
    String? requesterId = await fetchRequesterId(productId);
    if (requesterId != null) {
      return Request(
        fromUserId: fromUserId,
        productId: productId,
        requesterId: requesterId,
        accepted: false,
      );
    } else {
      throw Exception('Owner not found: $productId');
    }
  }
  static Future<String?> fetchRequesterId(String productId) async {
    try {
      final productCollection = FirebaseFirestore.instance.collection('products');
      DocumentSnapshot productSnapshot = await productCollection.doc(productId).get();

      if (productSnapshot.data() is Map<String, dynamic>) {

        Map<String, dynamic> data = productSnapshot.data() as Map<String, dynamic>;

        if (data.containsKey('userId')) {
          return data['userId'] as String?;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching requesterId!: $e");
      return null;
    }
  }

  RequestEntity toEntity() {
    return RequestEntity(
      id: id,
      requesterId: requesterId,
      fromUserId: fromUserId,
      productId: productId,
      accepted: accepted,
    );
  }
  static Request fromEntity(RequestEntity entity) {
    return Request(
      id: entity.id,
      requesterId: entity.requesterId,
      fromUserId: entity.fromUserId,
      productId: entity.productId,
      accepted: entity.accepted,
    );
  }
}
