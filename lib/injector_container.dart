import './constants/imports.dart';

late Dio dio;

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDio();
}

Future<void> initDio() async {
  dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
}
