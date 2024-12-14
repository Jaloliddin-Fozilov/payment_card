import '../../constants/imports.dart';

class AppTheme {
  ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.green,
    primaryColor: AppColors.primaryColor,
    useMaterial3: false,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.primaryColor),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30, height: 1.2),
      headlineMedium: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20, height: 1.2),
      headlineSmall: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16, height: 1.3),
      bodyLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14, height: 1.4),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 14, height: 1.6),
      bodySmall: TextStyle(color: Colors.black, fontSize: 12, height: 1.6),
      labelLarge: TextStyle(color: Colors.black, fontSize: 16, height: 1.2),
    ),
    inputDecorationTheme: const InputDecorationTheme(),
  );
}
