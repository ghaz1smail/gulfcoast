class AppModel {
  final bool server;
  final List? admins;
  final String wallet;

  AppModel({
    this.server = false,
    this.admins,
    this.wallet = '',
  });

  factory AppModel.fromJson(Map json) {
    return AppModel(
        server: json['server'] ?? false,
        admins: json['admins'] ?? [],
        wallet: json['wallet'] ?? '');
  }
}
