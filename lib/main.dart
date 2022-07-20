import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/global/themes/theme_service.dart';
import 'app/global/themes/themes.dart';
import 'app/global/translation/translations_service.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().getThemeMode(),
      translations: Translation(),
      locale: const Locale('fr'),
      fallbackLocale: const Locale('fr'),
      initialRoute: AppPages.LOGIN,
      unknownRoute: AppPages.unknownRoutePage,
      getPages: AppPages.routes,
    );
  }
}
