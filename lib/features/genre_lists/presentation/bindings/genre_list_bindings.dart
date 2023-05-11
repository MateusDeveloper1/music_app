import 'package:get/get.dart';
import 'package:music_app/features/genre_lists/presentation/controllers/genre_list_controller.dart';

class GenreListBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(GenreListController());
  }

}