class Districts {
 late String ilceId;
 late String ilceTitle;
 late  String ilceKey;
 late String ilceSehirkey;

  Districts({ required this.ilceId,required this.ilceTitle,required this.ilceKey,required this.ilceSehirkey});

  Districts.fromJson(Map<String, dynamic> json) {
    ilceId = json['ilce_id'];
    ilceTitle = json['ilce_title'];
    ilceKey = json['ilce_key'];
    ilceSehirkey = json['ilce_sehirkey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ilce_id'] = this.ilceId;
    data['ilce_title'] = this.ilceTitle;
    data['ilce_key'] = this.ilceKey;
    data['ilce_sehirkey'] = this.ilceSehirkey;
    return data;
  }
}
