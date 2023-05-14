import 'package:get/get.dart';
import 'package:music_app/core/errors/failures.dart';
import 'package:music_app/features/genre_lists/data/repositories/genre_list_repository.dart';
import 'package:music_app/shared/models/genre_model.dart';

import '../../../../core/mixins/escreen_loading_and_error_mixin.dart';

class GenreListController extends GetxController with ScreenLoadingErrorMixin {
  final GenreListRepository _genreListRepository;
  

  GenreListController(GenreListRepository genreListRepository)
      : _genreListRepository = genreListRepository;

  final RxList<GenreModel> genres = RxList([]);

  @override
  void onInit(){
    getGenreList();
    super.onInit();
  }

  Future getGenreList() async {
    setLoadingToTrue();
    setError(null);

    final getGenresResponse = await _genreListRepository.getGenreList();

    getGenresResponse.fold((Failure failureResponse){
      if(failureResponse is GetGenreListFailure) {
        setError(failureResponse.message);
      }
    }, (List<GenreModel> genreResponse) {
      genres.value = genreResponse;
    });

    setLoadingToFalse();
  }
}
