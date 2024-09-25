class AppModel {
  final bool server;
  final String admin;
  final String ios;
  final List? locations;

  AppModel(
      {this.server = false, this.admin = '', this.ios = '', this.locations});

  factory AppModel.fromJson(Map json) {
    return AppModel(
        server: json['server'] ?? false,
        admin: json['admin'] ?? '',
        ios: json['ios'] ?? '',
        locations: json['locations'] ?? []);
  }
}
