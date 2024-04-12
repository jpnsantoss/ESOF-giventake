class ProductEntity {
  final String id;
  final String title;
  final String description;
  final String image;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
    };
  }

  static ProductEntity fromDocument(Map<String, dynamic> doc) {
    return ProductEntity(
      id: doc['id'] as String,
      title: doc['title'] as String,
      description: doc['description'] as String,
      image: doc['image'] as String,
    );
  }
}
