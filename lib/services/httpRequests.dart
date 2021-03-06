import 'dart:convert';

import 'package:http/http.dart' as http;

String stagingApi = 'http://134.122.28.183/api/v1';
String prodApi = 'http://159.203.113.181/api/v1/';

getRequest(String path, isStaging) async {
  String api = isStaging ? stagingApi : prodApi;

  final response = await http.get('$api$path', headers: {
    "Accept": "application/json",
    "Content-Type": "application/json",
  });

  if (response.statusCode < 200 || response.statusCode > 400 || json == null) {
    throw new Exception("Error while fetching data");
  }

  return response.body;
}
