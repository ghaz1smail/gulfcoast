import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gulfcoast/models/user_model.dart';

class CarModel {
  final String vin;
  final String year;
  final String make;
  final String model;
  final String trim;
  final String engine;
  final String madeIn;
  final String steeringType;
  final String antiBrakeSystem;
  final String type;
  final String overallHeight;
  final String overallLength;
  final String overallWidth;
  final String standardSeating;
  final String highwayMileage;
  final String cityMileage;
  final String fuelType;
  final String driveType;
  final String transmission;
  final String status;
  final UserModel? userData;
  List? images;
  final DocumentReference? userId;

  CarModel(
      {this.vin = '',
      this.year = '',
      this.make = '',
      this.model = '',
      this.trim = '',
      this.engine = '',
      this.madeIn = '',
      this.steeringType = '',
      this.antiBrakeSystem = '',
      this.type = '',
      this.overallHeight = '',
      this.overallLength = '',
      this.overallWidth = '',
      this.standardSeating = '',
      this.highwayMileage = '',
      this.cityMileage = '',
      this.fuelType = '',
      this.driveType = '',
      this.transmission = '',
      this.status = '',
      this.userData,
      this.userId,
      this.images});

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
        vin: json['vin'] ?? '',
        year: json['year'] ?? '',
        make: json['make'] ?? '',
        model: json['model'] ?? '',
        trim: json['trim'] ?? '',
        engine: json['engine'] ?? '',
        madeIn: json['made_in'] ?? '',
        steeringType: json['steering_type'] ?? '',
        antiBrakeSystem: json['anti_brake_system'] ?? '',
        type: json['type'] ?? '',
        overallHeight: json['overall_height'] ?? '',
        overallLength: json['overall_length'] ?? '',
        overallWidth: json['overall_width'] ?? '',
        standardSeating: json['standard_seating'].toString(),
        highwayMileage: json['highway_mileage'].toString(),
        cityMileage: json['city_mileage'] ?? '',
        fuelType: json['fuel_type'] ?? '',
        driveType: json['drive_type'] ?? '',
        transmission: json['transmission'] ?? '',
        status: json['status'] ?? 'new',
        images: json['images'] ?? [],
        userId: json['userId'],
        userData: UserModel.fromJson(json['userData'] ?? {}));
  }

  Map<String, dynamic> toJson() {
    return {
      'vin': vin,
      'year': year,
      'make': make,
      'model': model,
      'trim': trim,
      'engine': engine,
      'made_in': madeIn,
      'steering_type': steeringType,
      'anti_brake_system': antiBrakeSystem,
      'type': type,
      'overall_height': overallHeight,
      'overall_length': overallLength,
      'overall_width': overallWidth,
      'standard_seating': standardSeating,
      'highway_mileage': highwayMileage,
      'city_mileage': cityMileage,
      'fuel_type': fuelType,
      'drive_type': driveType,
      'transmission': transmission,
      'images': images,
      'status': status,
      'userData': userData?.toJson() ?? {}
    };
  }
}
