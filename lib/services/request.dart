import 'dart:convert';

import 'package:nutty_putty_avatars/models/avatar.dart';
import 'package:nutty_putty_avatars/services/httpRequests.dart';

class AvatarService {
  getImages() async {
    try {
      var response = await getRequest('/images', false);

      return Avatar.fromJson(json.decode(response));
    } catch (e) {
      print(e);
    }
  }
}
