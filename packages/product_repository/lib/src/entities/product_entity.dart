class ProductEntity {
  final String id;
  final String title;
  final String description;
  final String location;
  final String image;
  final String userId;
  final DateTime createdAt;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.image,
    required this.userId,
    required this.createdAt,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'image': image,
      'userId': userId,
      'createdAt': createdAt,
    };
  }

  static ProductEntity fromDocument(Map<String, dynamic> doc) {
    return ProductEntity(
      id: doc['id'] as String,
      title: doc['title'] as String,
      description: doc['description'] as String,
      location: doc['location'] as String,
      image: doc['image'] as String,
      userId: doc['userId'] as String,
      createdAt: doc['createdAt'] as DateTime,
    );
  }
}
