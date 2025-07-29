import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/src/screens/general_page.dart';

void main() {
  // Configuración de la UI del sistema (status bar, etc.)
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromARGB(0, 255, 255, 255),
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

/// Widget raíz de la aplicación.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const GeneralPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}