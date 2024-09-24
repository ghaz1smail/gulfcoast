import 'package:cloud_firestore/cloud_firestore.dart';

class ResponseCarModel {
  final String vin;
  final List? errors;
  final CarModel? specs;

  ResponseCarModel({
    this.vin = '',
    this.errors,
    this.specs,
  });

  factory ResponseCarModel.fromJson(Map json) {
    return ResponseCarModel(
      vin: json['vin'] ?? '',
      errors: json['errors'] ?? [],
      specs: json['specs'] != null ? CarModel.fromJson(json['specs']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vin': vin,
      'errors': errors,
      'specs': specs?.toJson(),
    };
  }
}

class CarModel {
  final String abs;
  final String adaptiveDrivingBeam;
  final String airBagLocFront;
  final String airBagLocSide;
  final String autoReverseSystem;
  final String bodyCabType;
  final String bodyClass;
  final String brakeSystemType;
  final String customMotorcycleType;
  final String daytimeRunningLight;
  final String displacementCc;
  final String displacementCi;
  final String displacementL;
  final String driveType;
  final String esc;
  final String engineConfiguration;
  final String engineCylinders;
  final String engineHp;
  final String engineManufacturer;
  final String fuelTypePrimary;
  final String gvwr;
  final String keylessIgnition;
  final String lowerBeamHeadlampLightSource;
  final String make;
  final String makeId;
  final String manufacturer;
  final String manufacturerId;
  final String model;
  final String modelId;
  final String modelYear;
  final String note;
  final String parkAssist;
  final String plantCity;
  final String plantCompanyName;
  final String plantCountry;
  final String plantState;
  final String rearVisibilitySystem;
  final String seatBeltsAll;
  final String semiautomaticHeadlampBeamSwitching;
  final String series;
  final String series2;
  final String steeringLocation;
  final String tpms;
  final String tractionControl;
  final String trailerBodyType;
  final String trailerType;
  final String trim;
  final String vehicleDescriptor;
  final String vehicleType;
  final String price;
  final String status;
  final String timestamp;
  String vin;
  String lot;
  List? images;
  List? tags;
  final DocumentReference? userId;

  CarModel(
      {this.abs = '',
      this.adaptiveDrivingBeam = '',
      this.airBagLocFront = '',
      this.airBagLocSide = '',
      this.autoReverseSystem = '',
      this.bodyCabType = '',
      this.bodyClass = '',
      this.brakeSystemType = '',
      this.customMotorcycleType = '',
      this.daytimeRunningLight = '',
      this.displacementCc = '',
      this.displacementCi = '',
      this.displacementL = '',
      this.driveType = '',
      this.esc = '',
      this.engineConfiguration = '',
      this.engineCylinders = '',
      this.engineHp = '',
      this.engineManufacturer = '',
      this.fuelTypePrimary = '',
      this.gvwr = '',
      this.keylessIgnition = '',
      this.lowerBeamHeadlampLightSource = '',
      this.make = '',
      this.makeId = '',
      this.manufacturer = '',
      this.manufacturerId = '',
      this.model = '',
      this.modelId = '',
      this.modelYear = '',
      this.note = '',
      this.parkAssist = '',
      this.plantCity = '',
      this.plantCompanyName = '',
      this.plantCountry = '',
      this.plantState = '',
      this.rearVisibilitySystem = '',
      this.seatBeltsAll = '',
      this.semiautomaticHeadlampBeamSwitching = '',
      this.series = '',
      this.series2 = '',
      this.steeringLocation = '',
      this.tpms = '',
      this.tractionControl = '',
      this.trailerBodyType = '',
      this.trailerType = '',
      this.trim = '',
      this.vehicleDescriptor = '',
      this.vehicleType = '',
      this.price = '',
      this.status = 'new',
      this.vin = '',
      this.userId,
      this.timestamp = '',
      this.tags,
      this.lot = '',
      this.images});

  factory CarModel.fromJson(Map json) {
    return CarModel(
        abs: json['abs'] ?? '',
        adaptiveDrivingBeam: json['adaptive_driving_beam'] ?? '',
        airBagLocFront: json['air_bag_loc_front'] ?? '',
        airBagLocSide: json['air_bag_loc_side'] ?? '',
        autoReverseSystem: json['auto_reverse_system'] ?? '',
        bodyCabType: json['body_cab_type'] ?? '',
        bodyClass: json['body_class'] ?? '',
        brakeSystemType: json['brake_system_type'] ?? '',
        customMotorcycleType: json['custom_motorcycle_type'] ?? '',
        daytimeRunningLight: json['daytime_running_light'] ?? '',
        displacementCc: json['displacement_cc'] ?? '',
        displacementCi: json['displacement_ci'] ?? '',
        displacementL: json['displacement_l'] ?? '',
        driveType: json['drive_type'] ?? '',
        esc: json['esc'] ?? '',
        engineConfiguration: json['engine_configuration'] ?? '',
        engineCylinders: json['engine_cylinders'] ?? '',
        engineHp: json['engine_hp'] ?? '',
        engineManufacturer: json['engine_manufacturer'] ?? '',
        fuelTypePrimary: json['fuel_type_primary'] ?? '',
        gvwr: json['gvwr'] ?? '',
        keylessIgnition: json['keyless_ignition'] ?? '',
        lowerBeamHeadlampLightSource:
            json['lower_beam_headlamp_light_source'] ?? '',
        make: json['make'].toString().toUpperCase(),
        makeId: json['make_id'] ?? '',
        manufacturer: json['manufacturer'] ?? '',
        manufacturerId: json['manufacturer_id'] ?? '',
        model: json['model'].toString().toUpperCase(),
        modelId: json['model_id'] ?? '',
        modelYear: json['model_year'] ?? '',
        note: json['note'] ?? '',
        parkAssist: json['park_assist'] ?? '',
        plantCity: json['plant_city'] ?? '',
        plantCompanyName: json['plant_company_name'] ?? '',
        plantCountry: json['plant_country'] ?? '',
        plantState: json['plant_state'] ?? '',
        rearVisibilitySystem: json['rear_visibility_system'] ?? '',
        seatBeltsAll: json['seat_belts_all'] ?? '',
        semiautomaticHeadlampBeamSwitching:
            json['semiautomatic_headlamp_beam_switching'] ?? '',
        series: json['series'] ?? '',
        series2: json['series2'] ?? '',
        steeringLocation: json['steering_location'] ?? '',
        tpms: json['tpms'] ?? '',
        tractionControl: json['traction_control'] ?? '',
        trailerBodyType: json['trailer_body_type'] ?? '',
        trailerType: json['trailer_type'] ?? '',
        trim: json['trim'] ?? '',
        vehicleDescriptor: json['vehicle_descriptor'] ?? '',
        vehicleType: json['vehicle_type'] ?? '',
        userId: json['userId'],
        images: json['images'] ?? [],
        vin: json['vin'] ?? '',
        timestamp: json['timestamp'] ?? '',
        tags: json['tags'] ?? [],
        lot: json['lot'] ?? '',
        price: json['price'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'abs': abs,
      'adaptive_driving_beam': adaptiveDrivingBeam,
      'air_bag_loc_front': airBagLocFront,
      'air_bag_loc_side': airBagLocSide,
      'auto_reverse_system': autoReverseSystem,
      'body_cab_type': bodyCabType,
      'body_class': bodyClass,
      'brake_system_type': brakeSystemType,
      'custom_motorcycle_type': customMotorcycleType,
      'daytime_running_light': daytimeRunningLight,
      'displacement_cc': displacementCc,
      'displacement_ci': displacementCi,
      'displacement_l': displacementL,
      'drive_type': driveType,
      'esc': esc,
      'engine_configuration': engineConfiguration,
      'engine_cylinders': engineCylinders,
      'engine_hp': engineHp,
      'engine_manufacturer': engineManufacturer,
      'fuel_type_primary': fuelTypePrimary,
      'gvwr': gvwr,
      'keyless_ignition': keylessIgnition,
      'lower_beam_headlamp_light_source': lowerBeamHeadlampLightSource,
      'make': make.toLowerCase(),
      'make_id': makeId,
      'manufacturer': manufacturer,
      'manufacturer_id': manufacturerId,
      'model': model.toLowerCase(),
      'model_id': modelId,
      'model_year': modelYear,
      'note': note,
      'park_assist': parkAssist,
      'plant_city': plantCity,
      'plant_company_name': plantCompanyName,
      'plant_country': plantCountry,
      'plant_state': plantState,
      'rear_visibility_system': rearVisibilitySystem,
      'seat_belts_all': seatBeltsAll,
      'semiautomatic_headlamp_beam_switching':
          semiautomaticHeadlampBeamSwitching,
      'series': series,
      'series2': series2,
      'steering_location': steeringLocation,
      'tpms': tpms,
      'traction_control': tractionControl,
      'trailer_body_type': trailerBodyType,
      'trailer_type': trailerType,
      'trim': trim,
      'vehicle_descriptor': vehicleDescriptor,
      'vehicle_type': vehicleType,
      'timestamp': timestamp,
      'vin': vin,
      // 'price': price,
      // 'tags': tags,
      // 'lot': lot,
      // 'images': images,
      // 'status': status,
      // 'userId': userId,
    };
  }
}
