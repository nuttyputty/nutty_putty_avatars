import 'package:http/http.dart' as http;
import 'dart:convert';

bool isStaging = true;

String stagingApi = 'http://134.122.28.183/api/v1/';
String prodApi = 'http://159.203.113.181/api/v1/';

String API = isStaging ? stagingApi : prodApi;

getRequest(String path, [s3]) async {
  final response = await http.get('$API$path', headers: {
    "Accept": "application/json",
    "Content-Type": "application/json",
  });

  if (response.statusCode < 200 || response.statusCode > 400 || json == null) {
    throw new Exception("Error while fetching data");
  }

  return response.body;
}

postRequest(String path, bodyd, auth) async {
  return http.post('', body: json.encode(bodyd), headers: {
    "Accept": "application/json",
    "Content-Type": "application/json",
  }).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      return statusCode;
    }
    return response.body;
  });
}

patchRequest(String path, bodyd) async {
  return http.patch('', body: json.encode(bodyd), headers: {
    "Accept": "application/json",
    "Content-Type": "application/json"
  }).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return response.body;
  });
}
