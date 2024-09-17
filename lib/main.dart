import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/pages/home.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.yellow),
      // appBarTheme: const AppBarTheme(
      //   backgroundColor: Color.fromARGB(110, 250, 242, 7),
      //   shadowColor: Color.fromARGB(99, 239, 255, 65),
      //   titleTextStyle: TextStyle(
      //     color: Colors.black,
      //     fontWeight: FontWeight.bold,
      //     fontSize: 18,
      //   ),
      // ),
      //),
      home: const MyHomePage(),
    );
  }
}
