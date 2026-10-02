import '../../../../core/utils/image_helper.dart';

class Book {
  final String id;
  final String name;
  final String imageUrl;

  const Book({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as String? ?? 'LOTR Book';
    return Book(
      id: json['_id'] as String? ?? json['id'] as String? ?? '',
      name: name,
      imageUrl: ImageHelper.getBookImage(name),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}
