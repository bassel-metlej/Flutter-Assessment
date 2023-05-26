import 'package:flutter/material.dart';
import 'package:flutter_assessment/screens/nfts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.cyan,
          brightness: Brightness.dark,
          backgroundColor: const Color.fromARGB(255, 50, 58, 60),
        ),
      ),
      home: NftsListScreen(),
    );
  }
}
