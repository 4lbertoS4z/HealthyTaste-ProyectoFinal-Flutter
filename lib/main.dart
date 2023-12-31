import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:healthy_taste/di/app_module.dart';
import 'package:healthy_taste/presentation/navigation/navigation_routes.dart';

import 'generated/l10n.dart'; // Importa el archivo generado por flutter_intl

void main() {
  AppModules().setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // Configura los delegados de localización
      localizationsDelegates: const [
        S.delegate, // Delegado generado por flutter_intl
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Define los locales soportados
      supportedLocales: S.delegate.supportedLocales,

      // Configuración del router existente
      routerConfig: router,

      // Otras configuraciones de tu MaterialApp
      // Puedes añadir aquí configuraciones como theme, debugShowCheckedModeBanner, etc.
    );
  }
}
