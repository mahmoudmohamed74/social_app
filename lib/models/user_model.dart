class UserModel {
  String? name;
  String? email;
  String? phone;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;
  String? uId;

  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.isEmailVerified,
    this.cover,
    this.image,
    this.bio,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    name = json["name"];
    phone = json["phone"];
    uId = json["uId"];
    isEmailVerified = json["isEmailVerified"];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "name": name,
      "phone": phone,
      "uId": uId,
      "isEmailVerified": isEmailVerified,
      'bio': bio,
      'cover': cover,
      'image': image,
    };
  }
}
