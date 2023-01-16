import 'dart:convert';
import 'package:api_provider/Global/Global.dart';
import 'package:api_provider/Models/Model.dart';
import 'package:http/http.dart' as http;

class APIHelpers {
  APIHelpers._();

  static final APIHelpers apiHelpers = APIHelpers._();

  String baseURI = "https://jsonplaceholder.typicode.com";

  Future<List<Provider>?> getData() async {
    String api = baseURI + Global.endpoint;
    http.Response data = await http.get(Uri.parse(api));

    if (data.statusCode == 200) {
      List decodeData = jsonDecode(data.body);
      List<Provider> allData =
      decodeData.map((e) => Provider.fromMap(data: e)).toList();

      return allData;
    }
    return null;
  }
}
