import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/core/app/music_app_colors.dart';
import 'package:music_app/features/genre_details/presentation/screens/genre_details_screen.dart';
import 'package:music_app/features/genre_lists/presentation/bindings/genre_list_bindings.dart';
import 'package:music_app/features/genre_lists/presentation/screens/genre_list_screen.dart';

import '../../features/genre_details/presentation/bindings/genre_details_bindings.dart';

class MusicAppMaterial {
  MusicAppMaterial._();

  static String get getTitle => "Music App - Flutter Dicas Bootcamp";

  static List<GetPage> get getPages => [
        GetPage(
          name: GenreListScreen.routeName,
          page: () => const GenreListScreen(),
          binding: GenreListBindings(),
          children: [
            GetPage(
              name: GenreDetailScreen.routeName,
              page: () => const GenreDetailScreen(),
              binding: GenreDetailsBindings(),
            ),
          ],
        ),
      ];

  static ThemeData get getTheme => ThemeData(
        primaryColor: MusicAppColors.primaryColors,
        appBarTheme: AppBarTheme(
          backgroundColor: MusicAppColors.primaryColors,
          titleTextStyle: TextStyle(
            color: MusicAppColors.secondaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        fontFamily: 'Nunito',
      );
}
