import '../../../../core/utils/image_helper.dart';

class Movie {
  final String id;
  final String name;
  final int runtimeInMinutes;
  final double budgetInMillions;
  final double boxOfficeRevenueInMillions;
  final int academyAwardNominations;
  final int academyAwardWins;
  final String imageUrl;

  const Movie({
    required this.id,
    required this.name,
    required this.runtimeInMinutes,
    required this.budgetInMillions,
    required this.boxOfficeRevenueInMillions,
    required this.academyAwardNominations,
    required this.academyAwardWins,
    required this.imageUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as String? ?? 'LOTR Film';
    return Movie(
      id: json['_id'] as String? ?? json['id'] as String? ?? '',
      name: name,
      runtimeInMinutes: (json['runtimeInMinutes'] as num?)?.toInt() ?? 0,
      budgetInMillions: (json['budgetInMillions'] as num?)?.toDouble() ?? 0.0,
      boxOfficeRevenueInMillions:
          (json['boxOfficeRevenueInMillions'] as num?)?.toDouble() ?? 0.0,
      academyAwardNominations:
          (json['academyAwardNominations'] as num?)?.toInt() ?? 0,
      academyAwardWins: (json['academyAwardWins'] as num?)?.toInt() ?? 0,
      imageUrl: ImageHelper.getMovieImage(name),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'runtimeInMinutes': runtimeInMinutes,
      'budgetInMillions': budgetInMillions,
      'boxOfficeRevenueInMillions': boxOfficeRevenueInMillions,
      'academyAwardNominations': academyAwardNominations,
      'academyAwardWins': academyAwardWins,
      'imageUrl': imageUrl,
    };
  }
}
