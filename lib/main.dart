import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/savings_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/quote_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const CommunitySavingsApp());
}

class CommunitySavingsApp extends StatelessWidget {
  const CommunitySavingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SavingsProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => QuoteProvider()),
      ],
      child: MaterialApp(
        title: 'Community Savings',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF00C853), // Vibrant Green
            primary: const Color(0xFF00C853),
            secondary: const Color(0xFF2962FF), // Vibrant Blue
            surface: const Color(0xFFF8F9FA),
            background: const Color(0xFFF8F9FA),
          ),
          scaffoldBackgroundColor: const Color(0xFFF8F9FA),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Color(0xFF1B5E20),
            titleTextStyle: TextStyle(
              color: Color(0xFF1B5E20),
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          cardTheme: CardThemeData(
            elevation: 8,
            shadowColor: Colors.black.withOpacity(0.1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            color: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00C853),
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: const Color(0xFF00C853).withOpacity(0.4),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF00C853), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            labelStyle: TextStyle(color: Colors.grey[600]),
            prefixIconColor: const Color(0xFF00C853),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
