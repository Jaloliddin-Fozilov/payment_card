import '../constants/imports.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

sealed class AppRoutes {
  AppRoutes._();
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return CupertinoPageRoute(builder: (context) => const HomePage(), settings: settings);
      case Routes.selectImage:
        return CupertinoPageRoute(builder: (context) => const ChooseImagePage(), settings: settings);
      default:
        return null;
    }
  }
}
