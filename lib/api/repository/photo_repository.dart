import 'package:screen_decor/models/photo_model.dart';

import '../api_client.dart';

class PhotoRepository {
  ApiClient _apiClient = ApiClient();

  static final PhotoRepository _singleton = PhotoRepository._internal();

  factory PhotoRepository() {
    return _singleton;
  }

  PhotoRepository._internal();

  Future<List<PhotoModel>> getPhotos() async {
    return _apiClient.get<List<PhotoModel>, PhotoModel>(
      ApiClient.getPhotos,
    );
  }
}
