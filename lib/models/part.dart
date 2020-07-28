import 'package:nutty_putty_avatars/models/person.dart';

class AvatarPart {
  int part;
  String partImage;
  List<Items> items;

  AvatarPart({this.part, this.partImage, this.items});

  AvatarPart.fromJson(Map<String, dynamic> json) {
    part = json['part'];
    partImage = json['partImage'];
    if (json['items'] != null) {
      items = List<Items>();
      json['items'].forEach((v) {
        items.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['part'] = this.part;
    data['partImage'] = this.partImage;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String type;
  String title;
  String subpart;
  List<Element> parts;
  List<String> colors;
  bool slider;
  Items(
      {this.type,
      this.title,
      this.subpart,
      this.parts,
      this.colors,
      this.slider});

  Items.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    subpart = json['subpart'];
    if (json['parts'] != null) {
      parts = List<Element>();
      json['parts'].forEach((v) {
        parts.add(Element.fromJson(v));
      });
    }
    if (json['colors'] != null) {
      colors = json['colors'].cast<String>();
    }

    if (json['slider'] != null) {
      slider = json['slider'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    data['subpart'] = this.subpart;
    if (this.parts != null) {
      data['parts'] = this.parts.map((v) => v.toJson()).toList();
    }
    if (this.colors != null) {
      data['colors'] = this.colors;
    }
    if (this.slider != null) {
      data['slider'] = this.slider;
    }
    return data;
  }
}
