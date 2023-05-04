import 'dart:io';

import 'package:been_memory_love/pages/home_page.dart';
import 'package:been_memory_love/pages/lading_page.dart';
import 'package:been_memory_love/pages/ManagerFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    HttpClient client = super.createHttpClient(context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/loading_page',
      routes: {
        '/loading_page': (context) => const LadingPage(),
        '/home_page': (context) => const HomePage(),
        '/manager_file': (context) => const AppFile(),
      },
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.pink[200], secondary: Colors.pink.shade200)),
      home: const LadingPage(),
    );
  }
}
