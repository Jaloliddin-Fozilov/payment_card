import './constants/imports.dart';

class PaymentCardApp extends StatelessWidget {
  const PaymentCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: rootNavigatorKey,
        initialRoute: Routes.home,
        title: 'Payment Card',
        theme: AppTheme().lightTheme,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
