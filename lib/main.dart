import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hogwarts_sorting_hat/app_theme.dart';
import 'package:hogwarts_sorting_hat/feature/details/details_screen.dart';
import 'package:hogwarts_sorting_hat/hive_boxes.dart';
import 'package:hogwarts_sorting_hat/feature/home/cubit/home_cubit.dart';
import 'package:hogwarts_sorting_hat/feature/home/home_screen.dart';
import 'package:hogwarts_sorting_hat/feature/home/repository/home_repository.dart';
import 'package:hogwarts_sorting_hat/models/attempted_character.dart';
import 'package:hogwarts_sorting_hat/models/character_model.dart';
import 'package:hogwarts_sorting_hat/services/cache_service/cache_service.dart';
import 'package:hogwarts_sorting_hat/services/files_service/files_service.dart';
import 'package:hogwarts_sorting_hat/services/files_service/local_files_service.dart';
import 'package:hogwarts_sorting_hat/services/files_service/remote_files_service.dart';
import 'package:hogwarts_sorting_hat/feature/splash/cubit/splash_cubit.dart';
import 'package:hogwarts_sorting_hat/feature/splash/get_landing_page.dart';
import 'package:hogwarts_sorting_hat/feature/splash/repository/splash_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterAdapter());
  filesBox = await Hive.openBox<String>('filesBox');
  charactersBox = await Hive.openBox<Character>('charactersBox');
  runApp(const MyApp());
}

final _router = GoRouter(
  initialLocation: '/GetLandingPage',
  routes: [
    GoRoute(
        path: '/GetLandingPage',
        builder: (context, state) => const GetLandingPage()),
    GoRoute(
        path: '/HomeScreen',
        builder: (context, state) {
          final args = state.extra as Map<String, int>?;
          final index = args?['index'] ?? 0;
          return HomeScreen(initialIndex: index);
        }),
    GoRoute(
        path: '/DetailsScreen',
        builder: (context, state) {
          final args = state.extra as Map<String, AttemptedCharacter>;
          return DetailsScreen(character: args['character']!);
        }),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SplashCubit(SplashRepository(CacheService()))),
        BlocProvider(
            create: (context) => HomeCubit(HomeRepository(
                cacheService: CacheService(),
                filesService: FilesService(
                    localFilesService: LocalFilesService(),
                    remoteFilesService: RemoteFilesService())))),
      ],
      child: MaterialApp.router(
        theme: AppTheme.theme,
        routerConfig: _router,
      ),
    );
  }
}
