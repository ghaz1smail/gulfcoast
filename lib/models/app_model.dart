class AppModel {
  final bool server;
  final String admin;
  final String ios;
  final String vehicledatabases;
  final List? locations;
  final bool showSignUp;

  AppModel(
      {this.server = false,
      this.admin = '',
      this.ios = '',
      this.locations,
      this.vehicledatabases = '',
      this.showSignUp = false});

  factory AppModel.fromJson(Map json) {
    return AppModel(
        server: json['server'] ?? false,
        admin: json['admin'] ?? '',
        ios: json['ios'] ?? '',
        vehicledatabases: json['vehicledatabases'] ?? '',
        locations: json['locations'] ?? [],
        showSignUp: json['showSignUp'] ?? false);
  }
}
