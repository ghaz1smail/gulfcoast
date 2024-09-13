class UserModel {
  String username;
  String gender;
  String name;
  String email;
  String profile;
  String address;
  String bio;
  String birth;
  String uid;
  String firstName;
  String lastName;
  String cover;
  String type;
  String phone;
  String password;
  String timestamp;
  bool ios;
  bool blocked;
  bool deleted;
  bool online;
  bool verified;
  List? tags;
  List? userUsingCode;
  String codeIUse;

  UserModel({
    this.username = '',
    this.gender = 'male',
    this.email = '',
    this.password = '',
    this.name = '',
    this.firstName = '',
    this.lastName = '',
    this.profile = '',
    this.birth = '',
    this.type = '',
    this.uid = '',
    this.cover = '',
    this.address = '',
    this.bio = '',
    this.phone = '',
    this.timestamp = '',
    this.ios = false,
    this.blocked = false,
    this.deleted = false,
    this.verified = false,
    this.online = false,
    this.tags,
    this.userUsingCode,
    this.codeIUse = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'gender': gender,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'profile': profile,
      'address': address,
      'bio': bio,
      'online': online,
      'birth': birth,
      'cover': cover,
      'type': type,
      'uid': uid,
      'phone': phone,
      'ios': ios,
      'blocked': blocked,
      'password': password,
      'verified': verified,
      'deleted': deleted,
      'timestamp': timestamp,
      'tags': tags,
      'userUsingCode': userUsingCode,
      'codeIUse': codeIUse,
    };
  }

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    var f = json['firstName'] ?? '';
    var l = json['lastName'] ?? '';
    return UserModel(
      username: json['username'] ?? '',
      gender: json['gender'] ?? '',
      email: json['email'] ?? '',
      name: f + ' ' + l,
      firstName: f,
      lastName: l,
      profile: json['profile'] ?? '',
      address: json['address'] ?? '',
      bio: json['bio'] ?? '',
      birth: json['birth'] ?? '',
      cover: json['cover'] ?? '',
      type: json['type'] ?? '',
      uid: json['uid'] ?? '',
      phone: json['phone'] ?? '',
      ios: json['ios'] ?? false,
      blocked: json['blocked'] ?? false,
      online: json['online'] ?? false,
      verified: json['verified'] ?? false,
      deleted: json['deleted'] ?? false,
      timestamp: json['timestamp'] ?? '',
      tags: json['tags'] ?? [],
      codeIUse: json['codeIUse'] ?? '',
      userUsingCode: json['userUsingCode'] ?? [],
    );
  }
}
