import 'dart:convert';

import 'package:nutty_putty_avatars/models/avatar.dart';
import 'package:nutty_putty_avatars/services/httpRequests.dart';

class AvatarService {
  getImages(bool isStaging) async {
    try {
      print('[IS STAGING] $isStaging');
      var response = await getRequest('/images', isStaging);
      print('[RESPONSE] $response');
      return Avatar.fromJson(json.decode(response));
    } catch (e) {
      print('[ERROR] $e');
    }
  }
}
