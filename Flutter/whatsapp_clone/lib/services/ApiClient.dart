
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:whatsapp_clone/core/constant/app_route.dart';

class ApiClient{
  final Dio dio = Dio();
  final storage= const FlutterSecureStorage();

  ApiClient(){
    // dio.options.baseUrl='http://192.168.100.191:8000';
    dio.options.baseUrl='https://chat-hub-backend-a7y4.onrender.com/';
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options,handler)async{
      final token = await storage.read(key: 'jwt_token');
      if(token!=null){
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
    onError: (e,handler)async{
      if (e.response?.statusCode == 401&& e.requestOptions.path.contains('/auth/login/')) {
        await storage.delete(key: 'jwt_token');
        Get.snackbar('Session expired', 'Please login again');
        Get.offAllNamed(AppRoute.login);
      }
      return handler.next(e);
    }));
  }
}