import 'package:music_app/shared/models/genre_model.dart';
import 'package:music_app/shared/models/music_model.dart';

class GenreDetailsModel extends GenreModel {
  final List<MusicModel> musics;

  GenreDetailsModel({
    required super.title,
    super.img,
    required this.musics,
    required super.searchString,
  });

  factory GenreDetailsModel.fromMap(Map<String, dynamic> map) {
    return GenreDetailsModel(
      title: map['title'] ?? '',
      musics: (map['musics'] as List)
          .map((music) => MusicModel.fromMap(music))
          .toList(),
      searchString: map['searchString'] ?? '',
      img: map['img'] ?? '',
    );
  }
}
