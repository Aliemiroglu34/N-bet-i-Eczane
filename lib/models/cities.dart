class Cities {
 late String id;
 late String name;
 late String latitude;
 late String longitude;
 late String population;
 late String region;

  Cities(
      {required this.id,
        required this.name,
        required this.latitude,
        required this.longitude,
        required this.population,
        required this.region});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    population = json['population'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['population'] = this.population;
    data['region'] = this.region;
    return data;
  }
}
