class AppModel {
  final bool server;
  final String admin;
  final String ios;

  AppModel({
    this.server = false,
    this.admin = '',
    this.ios = '',
  });

  factory AppModel.fromJson(Map json) {
    return AppModel(
        server: json['server'] ?? false,
        admin: json['admin'] ?? '',
        ios: json['ios'] ?? '');
  }
}
