import 'package:dio/dio.dart';


class DioHelper {

  static late Dio dio;

  static init(){
    dio=Dio(
      BaseOptions(
         baseUrl:"https://student.valuxapps.com/api/" ,
        receiveDataWhenStatusError: true,

      )
    );
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? query,
    String lang='en',
    String? token,
  }) async {
    dio.options.headers=
         {
           'Content-Type':'application/json',
          'lang':lang,
          'Authorization':token
        };
    return await dio.get(path, queryParameters: query);
  }

  static Future<Response> postData(
      {
        required String path,
        Map<String, dynamic>? query,
        required Map<String, dynamic> data,
        String lang='en',
        String? token,
      }
      )async{

    dio.options.headers=
    {
      'lang':lang,
      'Authorization':token
    };

    return dio.post(
        path,
      queryParameters: query,
      data: data
    );

  }

  static Future<Response> putData(
      {
        required String path,
        Map<String, dynamic>? query,
        required Map<String, dynamic> data,
        String lang='en',
        String? token,
      }
      )async{

    dio.options.headers=
    {
      'lang':lang,
      'Authorization':token
    };

    return dio.put(
        path,
        queryParameters: query,
        data: data
    );

  }



}