import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/features/genre_details/presentation/screens/genre_details_screen.dart';
import 'package:music_app/features/genre_lists/presentation/controllers/genre_list_controller.dart';
import 'package:music_app/shared/widgets/screen_widget.dart';

import '../../../../shared/widgets/img_and_title_row_widget.dart';

class GenreListScreen extends StatelessWidget {
  static const routeName = '/genre-list';
  const GenreListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final genreListCtrl = Get.find<GenreListController>();

    return Obx(
      () => ScreenWidgets(
        isLoading: false,
        title: "Lista de Gêneros",
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                    itemBuilder: (_, int index) {
                      final genre = genreListCtrl.genres[index];
                      return InkWell(
                        onTap: () => Get.toNamed(
                            '${GenreListScreen.routeName}${GenreDetailScreen.routeName}',
                            arguments: genre),
                        child: ImgAndTitleRowWidget(
                          title: genre.title,
                          heroTag: genre.title,
                          img: genre.img,
                        ),
                      );
                    },
                    separatorBuilder: (_, __) {
                      return const SizedBox(height: 12);
                    },
                    itemCount: genreListCtrl.genres.length),
              ),
            ),
            const SizedBox(height: 12)
          ],
        ),
      ),
    );
  }
}
