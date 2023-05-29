import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' as get_x;

import '../../../constants/app_url.dart';

class ApiService {
  static final _options = BaseOptions(
    baseUrl: AppUrl.baseUrl,
    connectTimeout: const Duration(seconds: AppUrl.connectionTimeout),
    receiveTimeout: const Duration(seconds: AppUrl.receiveTimeout),
    responseType: ResponseType.json,
  );
  final _storage = const FlutterSecureStorage();

  final Dio _dio = Dio(_options)..interceptors.add(LogInterceptor());

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      options = await _updateOption(options);

      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      options = await _updateOption(options);

      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /*static dynamic _processResponse(Response response) {
    switch (response.statusCode) {
      case 200:

        return responseJson;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
        var responseError =
        MainModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
        // Get.snackbar(
        //     'Ошибка', responseError.message ?? 'Error message not found');
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 404:
        var responseError =
        MainModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
        Get.snackbar(
            'Ошибка', responseError.message ?? 'Error message not found');
        throw NotFoundException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 422:
        var responseError =
        MainModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
        Get.snackbar(
            'Ошибка', responseError.message ?? 'Error message not found');
        throw UnprocessableEntity(
            responseError.message ?? 'Error message not found',
            response.request!.url.toString());
      default:
        throw FetchDataException(
            'Error occurred with code ${response.statusCode}',
            response.request!.url.toString());
    }


  }*/

  Future<Options?> _updateOption(Options? options) async {
    final t = await _storage.read(key: 'token');
    final c = await _storage.read(key: 'companyId');
    print('token = > $t');
    print('companyId = > $c');
    if (t == null && c == null) {
      return options;
    }
    Options op = Options();
    if (options != null) {
      op = options;
    }
    Map<String, dynamic> headers = {};
    if (op.headers != null) {
      headers = op.headers!;
    }
    final deviceId = await _getId();
    final devicePlatform = get_x.GetPlatform();
    headers.addAll({HttpHeaders.authorizationHeader: 'Bearer $t'});
    headers.addAll({'companyId': '$c'});
    headers.addAll({'deviceId': '$deviceId'});
    headers.addAll({'devicePlatform': '$devicePlatform'});

    op.headers = headers;

    return op;
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    }
  }
}
