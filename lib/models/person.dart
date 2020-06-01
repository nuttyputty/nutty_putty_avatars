class Person {
  Part background;
  Part head;
  Part hair;
  Part hats;
  Part eyes;
  Part noses;
  Part mouth;
  Part faceHairs;
  Part clothes;
  Part accessories;
  Part eyebrows;

  Person(
      {this.background,
      this.head,
      this.hair,
      this.hats,
      this.eyes,
      this.noses,
      this.mouth,
      this.faceHairs,
      this.clothes,
      this.accessories,
      this.eyebrows});

  Person.fromJson(Map<String, dynamic> json) {
    background = json['background'] != null
        ? new Part.fromJson(json['background'])
        : null;
    head = json['head'] != null ? new Part.fromJson(json['head']) : null;
    hair = json['hair'] != null ? new Part.fromJson(json['hair']) : null;
    hats = json['hats'] != null ? new Part.fromJson(json['hats']) : null;
    eyes = json['eyes'] != null ? new Part.fromJson(json['eyes']) : null;
    noses = json['noses'] != null ? new Part.fromJson(json['noses']) : null;
    mouth = json['mouth'] != null ? new Part.fromJson(json['mouth']) : null;
    faceHairs = json['face_hairs'] != null
        ? new Part.fromJson(json['face_hairs'])
        : null;
    clothes =
        json['clothes'] != null ? new Part.fromJson(json['clothes']) : null;
    accessories = json['accessories'] != null
        ? new Part.fromJson(json['accessories'])
        : null;
    eyebrows =
        json['eyebrows'] != null ? new Part.fromJson(json['eyebrows']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.background != null) {
      data['background'] = this.background.toJson();
    }
    if (this.head != null) {
      data['head'] = this.head.toJson();
    }
    if (this.hair != null) {
      data['hair'] = this.hair.toJson();
    }
    if (this.hats != null) {
      data['hats'] = this.hats.toJson();
    }
    if (this.eyes != null) {
      data['eyes'] = this.eyes.toJson();
    }
    if (this.noses != null) {
      data['noses'] = this.noses.toJson();
    }
    if (this.mouth != null) {
      data['mouth'] = this.mouth.toJson();
    }
    if (this.faceHairs != null) {
      data['face_hairs'] = this.faceHairs.toJson();
    }
    if (this.clothes != null) {
      data['clothes'] = this.clothes.toJson();
    }
    if (this.accessories != null) {
      data['accessories'] = this.accessories.toJson();
    }
    if (this.eyebrows != null) {
      data['eyebrows'] = this.eyebrows.toJson();
    }
    return data;
  }
}

class Part {
  String color;
  Element element;

  Part({this.color, this.element});

  Part.fromJson(Map<String, dynamic> json) {
    color = json['color'] != null ? json['color'] : null;
    element =
        json['element'] != null ? new Element.fromJson(json['element']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.color != null) {
      data['color'] = this.color;
    }

    if (this.element != null) {
      data['element'] = this.element.toJson();
    }
    return data;
  }
}

class Element {
  String id;
  String image;
  bool free;
  String shadowImage;
  String longHairImage;
  String backImage;

  Element(
      {this.id,
      this.image,
      this.free,
      this.shadowImage,
      this.longHairImage,
      this.backImage});

  Element.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    free = json['free'];
    shadowImage = json['shadow_image'];
    longHairImage = json['long_hair_image'];
    backImage = json['back_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['free'] = this.free;
    data['shadow_image'] = this.shadowImage;
    data['long_hair_image'] = this.longHairImage;
    data['back_image'] = this.backImage;
    return data;
  }
}
