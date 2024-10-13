import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_explorer/domain/entites/folder.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<List<Folder>> fetchFolders() async {
    try {
      final response = await dio.get('http://192.168.1.8:3000/folders/allExpanded');

      // Check if the response data is a list
      if (response.data is List) {
        // Map the list to your Folder model
        return (response.data as List)
            .map((folderJson) => Folder.fromJson(folderJson))
            .toList();
      } else {
        throw Exception("Expected a list but got something else");
      }
    } on DioException catch (e) {
      // Handle Dio errors
      if (kDebugMode) {
        print('Dio error: ${e.message}');
      }
      return [];
    } catch (e) {
      // Handle other errors
      if (kDebugMode) {
        print('Dio error: ${e.toString()}');
      }
      return [];
    }
  }
}
