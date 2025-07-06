import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/inspection_provider.dart';
import 'screen/scorecardscreen.dart';

void main() {
  runApp(const ScorecardApp());
}

class ScorecardApp extends StatelessWidget {
  const ScorecardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InspectionProvider(),
      child: MaterialApp(
        title: 'Clean Train Scorecard',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2E7D32),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          cardColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1B5E20),
            foregroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF2E7D32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              elevation: 3,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            labelStyle: const TextStyle(color: Color(0xFF424242)),
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(fontSize: 16),
            titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            labelLarge: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        home: const ScorecardScreen(),
      ),
    );
  }
}
