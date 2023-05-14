import 'package:get/get.dart';
import 'package:music_app/core/services/api_services.dart';
import 'package:music_app/features/genre_lists/data/repositories/genre_list_repository.dart';
import 'package:music_app/features/genre_lists/presentation/controllers/genre_list_controller.dart';

class GenreListBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(
      GenreListController(
        GenreListRepository(
          apiService: Get.find<ApiService>(),
        ),
      ),
    );
  }
}
