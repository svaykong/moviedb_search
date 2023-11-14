import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'src/screens/screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: GoogleFonts.roboto().fontFamily,
        textTheme: TextTheme(
          titleMedium: GoogleFonts.robotoTextTheme().titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      home: const SearchScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
