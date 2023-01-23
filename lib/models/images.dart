class Images {
  List<Backdrops>? backdrop;
  List<Posters>? poster;
  List<Stills>? still;
  List<Logos>? logos;

  Images({
    this.backdrop,
    this.poster,
    this.still,
    this.logos,
  });

  Images.fromJson(Map<String, dynamic> json) {
    if (json['backdrops'] != null) {
      backdrop = [];
      json['backdrops'].forEach((v) {
        backdrop?.add(Backdrops.fromJson(v));
      });
    }
    if (json['posters'] != null) {
      poster = [];
      json['posters'].forEach((v) {
        poster?.add(Posters.fromJson(v));
      });
    }
    if (json['stills'] != null) {
      still = [];
      json['stills'].forEach((v) {
        still?.add(Stills.fromJson(v));
      });
    }
    if (json['logos'] != null) {
      logos = [];
      json['logos'].forEach((v) {
        logos?.add(Logos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (backdrop != null) {
      data['backdrops'] = backdrop?.map((v) => v.toJson()).toList();
    }
    if (poster != null) {
      data['posters'] = poster?.map((v) => v.toJson()).toList();
    }
    if (still != null) {
      data['stills'] = still?.map((v) => v.toJson()).toList();
    }
    if (logos != null) {
      data['logos'] = logos?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Backdrops {
  String? filePath;
  Backdrops({this.filePath});
  Backdrops.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_path'] = filePath;

    return data;
  }
}

class Posters {
  String? posterPath;
  Posters({this.posterPath});
  Posters.fromJson(Map<String, dynamic> json) {
    posterPath = json['file_path'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_path'] = posterPath;
    return data;
  }
}

class Stills {
  String? stillPath;
  Stills({this.stillPath});
  Stills.fromJson(Map<String, dynamic> json) {
    stillPath = json['file_path'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_path'] = stillPath;
    return data;
  }
}

class Logos {
  String? stillPath;
  Logos({this.stillPath});
  Logos.fromJson(Map<String, dynamic> json) {
    stillPath = json['file_path'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_path'] = stillPath;
    return data;
  }
}

class PersonImages {
  List<Profiles>? profile;
  PersonImages(this.profile);

  PersonImages.fromJson(Map<String, dynamic> json) {
    if (json['profiles'] != null) {
      profile = [];
      json['profiles'].forEach((v) {
        profile?.add(Profiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profile != null) {
      data['profiles'] = profile?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Profiles {
  String? filePath;
  Profiles(this.filePath);
  Profiles.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_path'] = filePath;

    return data;
  }
}
