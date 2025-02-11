import 'package:date_world/data/datasource/remote/dio/dio_client.dart';
import 'package:date_world/data/datasource/remote/exception/api_error_handler.dart';
import 'package:date_world/data/model/api_response.dart';
import 'package:date_world/features/contact_us/domain/models/contact_us_body.dart';
import 'package:date_world/features/contact_us/domain/repository/contact_us_repository_interface.dart';
import 'package:date_world/utill/app_constants.dart';

class ContactUsRepository implements ContactUsRepositoryInterface{
  final DioClient? dioClient;
  ContactUsRepository({this.dioClient});

  @override
  Future<ApiResponse> add(ContactUsBody contactUsBody) async {
    try {
      final response = await dioClient!.post(AppConstants.contactUsUri,
          data: {
            "name" :contactUsBody.name,
            "email" : contactUsBody.email,
            "mobile_number" : contactUsBody.phone,
            "subject" : contactUsBody.subject,
            "message" : contactUsBody.message
          });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }

}