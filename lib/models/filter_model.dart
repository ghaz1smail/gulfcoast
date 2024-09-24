class FilterModel {
  String title;
  List? cars;

  FilterModel({this.title = '', this.cars});

  factory FilterModel.fromJson(Map json) {
    return FilterModel(title: json['title'] ?? '', cars: json['cars'] ?? []);
  }
}
