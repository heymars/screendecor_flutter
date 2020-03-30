import 'package:screen_decor/models/photo_model.dart';

/// if T data is List then K is the subtype
class ApiResponse<T, K> {
  bool success;
  T data;
  String message;
  dynamic error;

  ApiResponse();

  @override
  String toString() {
    return "Success : $success \n Message : $message \n Data : $data \n Error: $error";
  }

  ApiResponse fromJson(dynamic json) {
//    success = json['success'];
//    message = json['message'];
//    dynamic genericData = json['data'];
    data = getDataFromJson<T, K>(json);
//    data = getDataFromJson<T, K>(genericData);
//    error = json['error'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['message'] = this.message;
    data['error'] = this.error;
    data['success'] = this.success;
    return data;
  }

  static T getDataFromJson<T, K>(dynamic json) {
    if (json is Iterable) {
      return _fromJsonList<K>(json) as T;
    } else if (T == PhotoModel) {
      return PhotoModel.fromJson(json) as T;
    } else if (T == Null) {
      return null;
    } else {
      throw Exception("Unknown class while parsing");
    }
  }

  static List<K> _fromJsonList<K>(List jsonList) {
    if (jsonList == null) {
      return null;
    }

    List<K> output = List();

    for (Map<String, dynamic> json in jsonList) {
      output.add(getDataFromJson<K, Null>(json));
    }

    return output;
  }
}
