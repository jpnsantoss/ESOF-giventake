class ProductEntity {
  final String id;
  final String title;
  final String description;
  final String location;
  final String image;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.image,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'image': image,
    };
  }

  static ProductEntity fromDocument(Map<String, dynamic> doc) {
    return ProductEntity(
      id: doc['id'] as String,
      title: doc['title'] as String,
      description: doc['description'] as String,
      location: doc['location'] as String,
      image: doc['image'] as String,
    );
  }
}
