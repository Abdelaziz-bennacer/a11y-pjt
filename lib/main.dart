import 'package:a11y_pjt/app/modules/login/controllers/login_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/global/themes/theme_service.dart';
import 'app/global/themes/themes.dart';
import 'app/global/translation/translations_service.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/

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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', 'FR'), // English, no country code
        //Locale('es', ''), // Spanish, no country code
      ],
      initialRoute: AppPages.LOGIN,
      unknownRoute: AppPages.unknownRoutePage,
      getPages: AppPages.routes,
    );
  }
}
