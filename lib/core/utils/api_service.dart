import '../../../constants/imports.dart';

class ApiService {
  ApiService();

  Future<dynamic> makeGetRequest(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(endpoint, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint('=================\n${e.response!.statusCode}\n$endpoint\n${e.response!}\n=================');
        throw e.response!.data;
      } else {
        throw 'Unknown error occurred';
      }
    }
  }

  Future<dynamic> makePostRequest(String endpoint, {Map<dynamic, dynamic>? data}) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      // Uncomment and implement real API call
      // final response = await dio.post(
      //   endpoint,
      //   data: data,
      // );
      // return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint('=================\n${e.response!.statusCode}\n$endpoint\n${e.response!}\n=================');
        throw e.response!.data;
      } else {
        throw 'Unknown error occurred';
      }
    }
  }

  Future<dynamic> makePatchRequest(String endpoint, {Map<dynamic, dynamic>? data}) async {
    try {
      final response = await dio.patch(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint('=================\n${e.response!.statusCode}\n$endpoint\n${e.response!}\n=================');
        throw e.response!.data;
      } else {
        throw 'Unknown error occurred';
      }
    }
  }

  Future<dynamic> makePutRequest(String endpoint, {Map<dynamic, dynamic>? data}) async {
    try {
      final response = await dio.put(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint('=================\n${e.response!.statusCode}\n$endpoint\n${e.response!}\n=================');
        throw e.response!.data;
      } else {
        throw 'Unknown error occurred';
      }
    }
  }

  Future<void> uploadImage(String endpoint, File imageFile, double blur) async {
    try {
      FormData formData = FormData.fromMap({
        "blue": blur,
        "file": await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });

      final response = await dio.post(
        endpoint,
        data: formData,
      );

      if (response.statusCode == 200) {
        print("Image uploaded successfully: ${response.data}");
      } else {
        print("Error while uploading image: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Error: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        print('Unknown error occurred');
      }
    }
  }
}
