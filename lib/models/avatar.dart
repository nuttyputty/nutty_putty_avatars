class Avatar {
  List<Accessories> accessories;
  List<Backgrounds> backgrounds;
  List<Clothes> clothes;
  List<Eyebrows> eyebrows;
  List<Eyes> eyes;
  List<FaceHairs> faceHairs;
  List<Hairs> hairs;
  List<HatHairs> hatHairs;
  List<Hats> hats;
  List<Heads> heads;
  List<Mouths> mouths;
  List<Noses> noses;

  Avatar(
      {this.accessories,
      this.backgrounds,
      this.clothes,
      this.eyebrows,
      this.eyes,
      this.faceHairs,
      this.hairs,
      this.hatHairs,
      this.hats,
      this.heads,
      this.mouths,
      this.noses});

  Avatar.fromJson(Map<String, dynamic> json) {
    if (json['accessories'] != null) {
      accessories = List<Accessories>();
      json['accessories'].forEach((v) {
        accessories.add(Accessories.fromJson(v));
      });
    }
    if (json['backgrounds'] != null) {
      backgrounds = List<Backgrounds>();
      json['backgrounds'].forEach((v) {
        backgrounds.add(Backgrounds.fromJson(v));
      });
    }
    if (json['clothes'] != null) {
      clothes = List<Clothes>();
      json['clothes'].forEach((v) {
        clothes.add(Clothes.fromJson(v));
      });
    }
    if (json['eyebrows'] != null) {
      eyebrows = List<Eyebrows>();
      json['eyebrows'].forEach((v) {
        eyebrows.add(Eyebrows.fromJson(v));
      });
    }
    if (json['eyes'] != null) {
      eyes = List<Eyes>();
      json['eyes'].forEach((v) {
        eyes.add(Eyes.fromJson(v));
      });
    }
    if (json['face_hairs'] != null) {
      faceHairs = List<FaceHairs>();
      json['face_hairs'].forEach((v) {
        faceHairs.add(FaceHairs.fromJson(v));
      });
    }
    if (json['hairs'] != null) {
      hairs = List<Hairs>();
      json['hairs'].forEach((v) {
        hairs.add(Hairs.fromJson(v));
      });
    }
    if (json['hat_hairs'] != null) {
      hatHairs = List<HatHairs>();
      json['hat_hairs'].forEach((v) {
        hatHairs.add(HatHairs.fromJson(v));
      });
    }
    if (json['hats'] != null) {
      hats = List<Hats>();
      json['hats'].forEach((v) {
        hats.add(Hats.fromJson(v));
      });
    }
    if (json['heads'] != null) {
      heads = List<Heads>();
      json['heads'].forEach((v) {
        heads.add(Heads.fromJson(v));
      });
    }
    if (json['mouths'] != null) {
      mouths = List<Mouths>();
      json['mouths'].forEach((v) {
        mouths.add(Mouths.fromJson(v));
      });
    }
    if (json['noses'] != null) {
      noses = List<Noses>();
      json['noses'].forEach((v) {
        noses.add(Noses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.accessories != null) {
      data['accessories'] = this.accessories.map((v) => v.toJson()).toList();
    }
    if (this.backgrounds != null) {
      data['backgrounds'] = this.backgrounds.map((v) => v.toJson()).toList();
    }
    if (this.clothes != null) {
      data['clothes'] = this.clothes.map((v) => v.toJson()).toList();
    }
    if (this.eyebrows != null) {
      data['eyebrows'] = this.eyebrows.map((v) => v.toJson()).toList();
    }
    if (this.eyes != null) {
      data['eyes'] = this.eyes.map((v) => v.toJson()).toList();
    }
    if (this.faceHairs != null) {
      data['face_hairs'] = this.faceHairs.map((v) => v.toJson()).toList();
    }
    if (this.hairs != null) {
      data['hairs'] = this.hairs.map((v) => v.toJson()).toList();
    }
    if (this.hatHairs != null) {
      data['hat_hairs'] = this.hatHairs.map((v) => v.toJson()).toList();
    }
    if (this.hats != null) {
      data['hats'] = this.hats.map((v) => v.toJson()).toList();
    }
    if (this.heads != null) {
      data['heads'] = this.heads.map((v) => v.toJson()).toList();
    }
    if (this.mouths != null) {
      data['mouths'] = this.mouths.map((v) => v.toJson()).toList();
    }
    if (this.noses != null) {
      data['noses'] = this.noses.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Accessories {
  String id;
  String image;
  bool free;
  bool customColor;

  Accessories({this.id, this.image, this.free});

  Accessories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    free = json['free'];
    free = json['custom_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['free'] = this.free;
    data['custom_color'] = this.customColor;
    return data;
  }
}

class Clothes {
  String id;
  String image;
  bool free;
  String shadowImage;

  Clothes({this.id, this.image, this.free, this.shadowImage});

  Clothes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    free = json['free'];
    shadowImage = json['shadow_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['free'] = this.free;
    data['shadow_image'] = this.shadowImage;
    return data;
  }
}

class Hairs {
  String id;
  String image;
  bool free;
  String shadowImage;
  String longHairImage;

  Hairs({this.id, this.image, this.free, this.shadowImage, this.longHairImage});

  Hairs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    free = json['free'];
    shadowImage = json['shadow_image'];
    longHairImage = json['long_hair_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['free'] = this.free;
    data['shadow_image'] = this.shadowImage;
    data['long_hair_image'] = this.longHairImage;
    return data;
  }
}

class Hats {
  String id;
  String image;
  bool free;
  String backImage;

  Hats({this.id, this.image, this.free, this.backImage});

  Hats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    free = json['free'];
    backImage = json['back_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['free'] = this.free;
    data['back_image'] = this.backImage;
    return data;
  }
}

class Backgrounds {
  String id;
  String image;
  bool free;

  Backgrounds({this.id, this.image, this.free});

  Backgrounds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    free = json['free'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['free'] = this.free;
    return data;
  }
}

class Eyes {
  String id;
  String image;
  bool free;
  String shadowImage;

  Eyes({this.id, this.image, this.free, this.shadowImage});

  Eyes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    free = json['free'];
    shadowImage = json['shadow_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['free'] = this.free;
    data['shadow_image'] = this.shadowImage;
    return data;
  }
}

class HatHairs {
  String id;
  String image;
  bool free;
  String shadowImage;
  String longHairImage;

  HatHairs(
      {this.id, this.image, this.free, this.shadowImage, this.longHairImage});

  HatHairs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    free = json['free'];
    shadowImage = json['shadow_image'];
    longHairImage = json['long_hair_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['free'] = this.free;
    data['shadow_image'] = this.shadowImage;
    data['long_hair_image'] = this.longHairImage;
    return data;
  }
}

class Eyebrows {
  String id;
  String image;
  bool free;

  Eyebrows({this.id, this.image, this.free});

  Eyebrows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    free = json['free'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['free'] = this.free;
    return data;
  }
}

class FaceHairs {
  String id;
  String image;
  bool free;
  String shadowImage;

  FaceHairs({this.id, this.image, this.free, this.shadowImage});

  FaceHairs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    free = json['free'];
    shadowImage = json['shadow_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['free'] = this.free;
    data['shadow_image'] = this.shadowImage;
    return data;
  }
}

class Heads {
  String id;
  String image;
  bool free;
  String shadowImage;

  Heads({this.id, this.image, this.free, this.shadowImage});

  Heads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    free = json['free'];
    shadowImage = json['shadow_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['free'] = this.free;
    data['shadow_image'] = this.shadowImage;
    return data;
  }
}

class Mouths {
  String id;
  String image;
  bool free;

  Mouths({this.id, this.image, this.free});

  Mouths.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    free = json['free'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['free'] = this.free;
    return data;
  }
}

class Noses {
  String id;
  String image;
  bool free;
  String shadowImage;

  Noses({this.id, this.image, this.free, this.shadowImage});

  Noses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    free = json['free'];
    shadowImage = json['shadow_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['free'] = this.free;
    data['shadow_image'] = this.shadowImage;
    return data;
  }
}
