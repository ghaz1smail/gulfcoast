class UserModel {
  String username;
  String name;
  String email;
  String profile;
  String address;
  String uid;
  String type;
  String phone;
  String password;
  String timestamp;
  bool ios;
  bool blocked;
  bool deleted;
  bool verified;
  List? tags;
  List? cars;
  String company;

  UserModel(
      {this.username = '',
      this.email = '',
      this.password = '',
      this.name = '',
      this.profile = '',
      this.type = '',
      this.uid = '',
      this.address = '',
      this.phone = '',
      this.timestamp = '',
      this.ios = false,
      this.blocked = false,
      this.deleted = false,
      this.verified = false,
      this.company = '',
      this.tags,
      this.cars});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'profile': profile,
      'address': address,
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
      'cars': cars,
      'company': company,
    };
  }

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      profile: json['profile'] ?? '',
      address: json['address'] ?? '',
      type: json['type'] ?? '',
      uid: json['uid'] ?? '',
      phone: json['phone'] ?? '',
      ios: json['ios'] ?? false,
      blocked: json['blocked'] ?? false,
      verified: json['verified'] ?? false,
      deleted: json['deleted'] ?? false,
      timestamp: json['timestamp'] ?? '',
      tags: json['tags'] ?? [],
      password: json['password'] ?? '',
      cars: json['cars'] ?? [],
      company: json['company'] ?? '',
    );
  }
}
