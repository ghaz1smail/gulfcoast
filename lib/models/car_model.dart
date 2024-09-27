import 'package:cloud_firestore/cloud_firestore.dart';

class CarModel {
  String bodyClass;
  String driveType;
  String fuelType;
  String make;
  String model;
  String modelYear;
  String note;
  String vehicleType;
  String price;
  String status;
  String timestamp;
  String invoice;
  String lotNumber;
  String vin;
  List<Destination>? destination;
  List? images;
  List? tags;
  TechnicalSpecs? technicalSpecs;
  DocumentReference? userId;

  CarModel(
      {this.bodyClass = '',
      this.driveType = '',
      this.fuelType = '',
      this.make = '',
      this.model = '',
      this.modelYear = '',
      this.note = '',
      this.vehicleType = '',
      this.price = '',
      this.status = 'new',
      this.vin = '',
      this.userId,
      this.timestamp = '',
      this.destination,
      this.tags,
      this.invoice = '',
      this.lotNumber = '',
      this.images});

  factory CarModel.fromJson(Map json) {
    List d = json['destination'] ?? [];
    return CarModel(
        bodyClass: json['body_class'] ?? '',
        driveType: json['drive_type'] ?? '',
        fuelType: json['fuel_type_primary'] ?? '',
        make: json['make'].toString().toUpperCase(),
        model: json['model'].toString().toUpperCase(),
        modelYear: json['year'] ?? json['model_year'] ?? '',
        note: json['note'] ?? '',
        vehicleType: json['vehicle_type'] ?? '',
        userId: json['userId'],
        images: json['images'] ?? [],
        vin: json['vin'] ?? '',
        timestamp: json['timestamp'] ?? '',
        tags: json['tags'] ?? [],
        lotNumber: json['lot-number'] ?? '',
        invoice: json['invoice'] ?? '',
        destination: d.map((m) => Destination.fromJson(m)).toList(),
        status: json['status'] ?? 'new',
        price: json['price']
            .toString()
            .replaceAll('N/A', '')
            .replaceAll('\$', '')
            .replaceAll(',', '')
            .replaceAll('null', ''));
  }

  Map<String, dynamic> toJson() {
    return {
      'body_class': bodyClass,
      'drive_type': driveType,
      'fuel_type_primary': fuelType,
      'make': make,
      'model': model,
      'vin': vin,
      'model_year': modelYear,
      'note': note,
      'vehicle_type': vehicleType,
      'userId': userId,
      'images': images,
      'price': price,
      'lot-number': lotNumber,
      'destination': destination
    };
  }
}

class VehicleData {
  bool vehicleDatabases;
  String? vin;
  List? errors;
  CarModel? carData;

  VehicleData(
      {this.vin, this.errors, this.carData, this.vehicleDatabases = true});

  factory VehicleData.fromJson(Map json, bool vehicleDatabases) {
    List v = json['data'] ?? [];
    return VehicleData(
      vin: json['vin'] ?? '',
      vehicleDatabases: vehicleDatabases,
      errors: json['errors'] ?? [],
      carData: vehicleDatabases
          ? CarModel.fromJson(v.first)
          : json['specs'] != null
              ? CarModel.fromJson(json['specs'])
              : null,
    );
  }
}

class TechnicalSpecs {
  String? odometer;
  String? estimatedRepairCost;
  String? avgEstimatedRetailValue;
  String? damageRatio;
  String? estimatedWinningBid;
  String? bodyStyle;
  String? color;
  String? engineType;
  String? fuelType;
  String? cylinders;
  String? transmission;
  String? drive;

  TechnicalSpecs({
    this.odometer,
    this.estimatedRepairCost,
    this.avgEstimatedRetailValue,
    this.damageRatio,
    this.estimatedWinningBid,
    this.bodyStyle,
    this.color,
    this.engineType,
    this.fuelType,
    this.cylinders,
    this.transmission,
    this.drive,
  });

  factory TechnicalSpecs.fromJson(Map<String, dynamic> json) {
    return TechnicalSpecs(
      odometer: json['Odometer'] ?? '',
      estimatedRepairCost: json['Estimated Repair Cost'] ?? '',
      avgEstimatedRetailValue: json['Avg. Estimated Retail Value'] ?? '',
      damageRatio: json['Damage Ratio'] ?? '',
      estimatedWinningBid: json['Estimated Winning Bid'] ?? '',
      bodyStyle: json['Body Style'] ?? '',
      color: json['Color'] ?? '',
      engineType: json['Engine Type'] ?? '',
      fuelType: json['Fuel Type'] ?? '',
      cylinders: json['Cylinders'] ?? '',
      transmission: json['Transmission'] ?? '',
      drive: json['Drive'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Odometer': odometer,
      'Estimated Repair Cost': estimatedRepairCost,
      'Avg. Estimated Retail Value': avgEstimatedRetailValue,
      'Damage Ratio': damageRatio,
      'Estimated Winning Bid': estimatedWinningBid,
      'Body Style': bodyStyle,
      'Color': color,
      'Engine Type': engineType,
      'Fuel Type': fuelType,
      'Cylinders': cylinders,
      'Transmission': transmission,
      'Drive': drive,
    };
  }
}

class Destination {
  String title;
  String timestamp;

  Destination({this.title = '', this.timestamp = ''});

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      title: json['title'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }
}
