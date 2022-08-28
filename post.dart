class Post {
  late String filePath;
  late String title;
  late String description;
  late Location location;
  late String category;

  Post({
    required this.filePath,
    required this.title,
    required this.description,
    required this.location,
    required this.category,
  });

  Post.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'];
    title = json['title'];
    description = json['description'];
    location = Location.fromJson(json['location']);
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['file_path'] = filePath;
    data['title'] = title;
    data['description'] = description;
    data['location'] = location.toJson();
    data['category'] = category;
    return data;
  }
}

class Location {
  late String latitude;
  late String longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
