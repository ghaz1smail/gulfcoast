class CarModel {
  String vehicleDescriptor;
  String make;
  String manufacturerName;
  String model;
  String modelYear;
  String plantCity;
  String series;
  String trim;
  String vehicleType;
  String plantCountry;
  String plantState;
  String bodyClass;
  String doors;
  String grossVehicleWeightRatingFrom;
  String grossVehicleWeightRatingTo;
  String numberOfSeats;
  String numberOfSeatRows;
  String transmissionStyle;
  String transmissionSpeeds;
  String engineCylinders;
  String displacementCC;
  String displacementCI;
  String displacementL;
  String fuelTypePrimary;
  String engineBrakeHpFrom;
  String otherEngineInfo;
  String engineManufacturer;
  String seatBeltType;
  String otherRestraintSystemInfo;
  String curtainAirBagLocations;
  String frontAirBagLocations;
  String sideAirBagLocations;
  String abs;
  String esc;
  String tractionControl;
  String tpmsType;
  String autoReverseSystem;
  String keylessIgnition;
  String ncsaBodyType;
  String ncsaMake;
  String ncsaModel;
  String acc;
  String cib;
  String bsw;
  String fcw;
  String ldw;
  String lka;
  String backupCamera;
  String dbs;
  String drl;
  String headlampLightSource;
  String semiautomaticHeadlampBeamSwitching;
  String adb;
  String rearCrossTrafficAlert;
  String rearAutomaticEmergencyBraking;
  List? images;

  CarModel(
      {this.vehicleDescriptor = '',
      this.make = '',
      this.manufacturerName = '',
      this.model = '',
      this.modelYear = '',
      this.plantCity = '',
      this.series = '',
      this.trim = '',
      this.vehicleType = '',
      this.plantCountry = '',
      this.plantState = '',
      this.bodyClass = '',
      this.doors = '',
      this.grossVehicleWeightRatingFrom = '',
      this.grossVehicleWeightRatingTo = '',
      this.numberOfSeats = '',
      this.numberOfSeatRows = '',
      this.transmissionStyle = '',
      this.transmissionSpeeds = '',
      this.engineCylinders = '',
      this.displacementCC = '',
      this.displacementCI = '',
      this.displacementL = '',
      this.fuelTypePrimary = '',
      this.engineBrakeHpFrom = '',
      this.otherEngineInfo = '',
      this.engineManufacturer = '',
      this.seatBeltType = '',
      this.otherRestraintSystemInfo = '',
      this.curtainAirBagLocations = '',
      this.frontAirBagLocations = '',
      this.sideAirBagLocations = '',
      this.abs = '',
      this.esc = '',
      this.tractionControl = '',
      this.tpmsType = '',
      this.autoReverseSystem = '',
      this.keylessIgnition = '',
      this.ncsaBodyType = '',
      this.ncsaMake = '',
      this.ncsaModel = '',
      this.acc = '',
      this.cib = '',
      this.bsw = '',
      this.fcw = '',
      this.ldw = '',
      this.lka = '',
      this.backupCamera = '',
      this.dbs = '',
      this.drl = '',
      this.headlampLightSource = '',
      this.semiautomaticHeadlampBeamSwitching = '',
      this.adb = '',
      this.rearCrossTrafficAlert = '',
      this.rearAutomaticEmergencyBraking = '',
      this.images});

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
        vehicleDescriptor: json['Vehicle Descriptor']?.toString() ?? '',
        make: json['Make']?.toString() ?? '',
        manufacturerName: json['Manufacturer Name']?.toString() ?? '',
        model: json['Model']?.toString() ?? '',
        modelYear: json['Model Year']?.toString() ?? '',
        plantCity: json['Plant City']?.toString() ?? '',
        series: json['Series']?.toString() ?? '',
        trim: json['Trim']?.toString() ?? '',
        vehicleType: json['Vehicle Type']?.toString() ?? '',
        plantCountry: json['Plant Country']?.toString() ?? '',
        plantState: json['Plant State']?.toString() ?? '',
        bodyClass: json['Body Class']?.toString() ?? '',
        doors: json['Doors']?.toString() ?? '',
        grossVehicleWeightRatingFrom:
            json['Gross Vehicle Weight Rating From']?.toString() ?? '',
        grossVehicleWeightRatingTo:
            json['Gross Vehicle Weight Rating To']?.toString() ?? '',
        numberOfSeats: json['Number of Seats']?.toString() ?? '',
        numberOfSeatRows: json['Number of Seat Rows']?.toString() ?? '',
        transmissionStyle: json['Transmission Style']?.toString() ?? '',
        transmissionSpeeds: json['Transmission Speeds']?.toString() ?? '',
        engineCylinders: json['Engine Number of Cylinders']?.toString() ?? '',
        displacementCC: json['Displacement (CC)']?.toString() ?? '',
        displacementCI: json['Displacement (CI)']?.toString() ?? '',
        displacementL: json['Displacement (L)']?.toString() ?? '',
        fuelTypePrimary: json['Fuel Type - Primary']?.toString() ?? '',
        engineBrakeHpFrom: json['Engine Brake (hp) From']?.toString() ?? '',
        otherEngineInfo: json['Other Engine Info']?.toString() ?? '',
        engineManufacturer: json['Engine Manufacturer']?.toString() ?? '',
        seatBeltType: json['Seat Belt Type']?.toString() ?? '',
        otherRestraintSystemInfo:
            json['Other Restraint System Info']?.toString() ?? '',
        curtainAirBagLocations:
            json['Curtain Air Bag Locations']?.toString() ?? '',
        frontAirBagLocations: json['Front Air Bag Locations']?.toString() ?? '',
        sideAirBagLocations: json['Side Air Bag Locations']?.toString() ?? '',
        abs: json['Anti-lock Braking System (ABS)']?.toString() ?? '',
        esc: json['Electronic Stability Control (ESC)']?.toString() ?? '',
        tractionControl: json['Traction Control']?.toString() ?? '',
        tpmsType:
            json['Tire Pressure Monitoring System (TPMS) Type']?.toString() ??
                '',
        autoReverseSystem:
            json['Auto-Reverse System for Windows and Sunroofs']?.toString() ??
                '',
        keylessIgnition: json['Keyless Ignition']?.toString() ?? '',
        ncsaBodyType: json['NCSA Body Type']?.toString() ?? '',
        ncsaMake: json['NCSA Make']?.toString() ?? '',
        ncsaModel: json['NCSA Model']?.toString() ?? '',
        acc: json['Adaptive Cruise Control (ACC)']?.toString() ?? '',
        cib: json['Crash Imminent Braking (CIB)']?.toString() ?? '',
        bsw: json['Blind Spot Warning (BSW)']?.toString() ?? '',
        fcw: json['Forward Collision Warning (FCW)']?.toString() ?? '',
        ldw: json['Lane Departure Warning (LDW)']?.toString() ?? '',
        lka: json['Lane Keeping Assistance (LKA)']?.toString() ?? '',
        backupCamera: json['Backup Camera']?.toString() ?? '',
        dbs: json['Dynamic Brake Support (DBS)']?.toString() ?? '',
        drl: json['Daytime Running Light (DRL)']?.toString() ?? '',
        headlampLightSource: json['Headlamp Light Source']?.toString() ?? '',
        semiautomaticHeadlampBeamSwitching:
            json['Semiautomatic Headlamp Beam Switching']?.toString() ?? '',
        adb: json['Adaptive Driving Beam (ADB)']?.toString() ?? '',
        rearCrossTrafficAlert:
            json['Rear Cross Traffic Alert']?.toString() ?? '',
        rearAutomaticEmergencyBraking:
            json['Rear Automatic Emergency Braking']?.toString() ?? '',
        images: json['Images'] ?? []);
  }

  Map<String, dynamic> toJson() {
    return {
      'Vehicle Descriptor': vehicleDescriptor,
      'Make': make,
      'Manufacturer Name': manufacturerName,
      'Model': model,
      'Model Year': modelYear,
      'Plant City': plantCity,
      'Series': series,
      'Trim': trim,
      'Vehicle Type': vehicleType,
      'Plant Country': plantCountry,
      'Plant State': plantState,
      'Body Class': bodyClass,
      'Doors': doors,
      'Gross Vehicle Weight Rating From': grossVehicleWeightRatingFrom,
      'Gross Vehicle Weight Rating To': grossVehicleWeightRatingTo,
      'Number of Seats': numberOfSeats,
      'Number of Seat Rows': numberOfSeatRows,
      'Transmission Style': transmissionStyle,
      'Transmission Speeds': transmissionSpeeds,
      'Engine Number of Cylinders': engineCylinders,
      'Displacement (CC)': displacementCC,
      'Displacement (CI)': displacementCI,
      'Displacement (L)': displacementL,
      'Fuel Type - Primary': fuelTypePrimary,
      'Engine Brake (hp) From': engineBrakeHpFrom,
      'Other Engine Info': otherEngineInfo,
      'Engine Manufacturer': engineManufacturer,
      'Seat Belt Type': seatBeltType,
      'Other Restraint System Info': otherRestraintSystemInfo,
      'Curtain Air Bag Locations': curtainAirBagLocations,
      'Front Air Bag Locations': frontAirBagLocations,
      'Side Air Bag Locations': sideAirBagLocations,
      'Anti-lock Braking System (ABS)': abs,
      'Electronic Stability Control (ESC)': esc,
      'Traction Control': tractionControl,
      'Tire Pressure Monitoring System (TPMS) Type': tpmsType,
      'Auto-Reverse System for Windows and Sunroofs': autoReverseSystem,
      'Keyless Ignition': keylessIgnition,
      'NCSA Body Type': ncsaBodyType,
      'NCSA Make': ncsaMake,
      'NCSA Model': ncsaModel,
      'Adaptive Cruise Control (ACC)': acc,
      'Crash Imminent Braking (CIB)': cib,
      'Blind Spot Warning (BSW)': bsw,
      'Forward Collision Warning (FCW)': fcw,
      'Lane Departure Warning (LDW)': ldw,
      'Lane Keeping Assistance (LKA)': lka,
      'Backup Camera': backupCamera,
      'Dynamic Brake Support (DBS)': dbs,
      'Daytime Running Light (DRL)': drl,
      'Headlamp Light Source': headlampLightSource,
      'Semiautomatic Headlamp Beam Switching':
          semiautomaticHeadlampBeamSwitching,
      'Adaptive Driving Beam (ADB)': adb,
      'Rear Cross Traffic Alert': rearCrossTrafficAlert,
      'Rear Automatic Emergency Braking': rearAutomaticEmergencyBraking,
      'images': images
    };
  }
}
