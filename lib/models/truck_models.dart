import 'package:fleet_sync/models/company_truck_abstract.dart';

class Truck extends FeedItem {
  String idValue;
  String? brand;
  String? model;
  int yearValue;
  String colorValue;
  int mileageValue;
  String cityValue;
  String stateValue;
  int cargoCapacityLbsValue;
  String fuelTypeValue;
  String engineTypeValue;
  String transmissionTypeValue;
  double priceValue;
  String vinValue;

  Truck(
    this.idValue,
    this.brand,
    this.model,
    this.yearValue,
    this.colorValue,
    this.mileageValue,
    this.cityValue,
    this.stateValue,
    this.cargoCapacityLbsValue,
    this.fuelTypeValue,
    this.engineTypeValue,
    this.transmissionTypeValue,
    this.priceValue,
    this.vinValue,
  );

  @override
  String get title => '$brand $model';

  @override
  String get location => '$cityValue, $stateValue';

  @override
  String? get id => idValue;

  @override
  String? get brandName => brand;

  @override
  String? get modelName => model;

  @override
  int? get year => yearValue;

  @override
  String? get color => colorValue;

  @override
  int? get mileage => mileageValue;

  @override
  String? get cityName => cityValue;

  @override
  String? get stateName => stateValue;

  @override
  int? get cargoCapacityLbs => cargoCapacityLbsValue;

  @override
  String? get fuelType => fuelTypeValue;

  @override
  String? get engineType => engineTypeValue;

  @override
  String? get transmissionType => transmissionTypeValue;

  @override
  double? get price => priceValue;

  @override
  String? get vin => vinValue;
}

class TruckModels {
  Future<List<Truck>> getTruckData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return trucks;
  }
}

class FeedTruckModels {
  Future<List<FeedItem>> getFeedTruckData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return trucks;
  }
}

final List<Truck> trucks = [
  Truck(
    '1', // id
    'Peterbilt', // brand
    '579', // model
    2022, // year
    'Red', // color
    125000, // mileage
    'Los Angeles', // city
    'California', // state
    60000, // cargoCapacityLbs
    'Diesel', // fuelType
    'Cummins X15', // engineType
    'Automatic', // transmissionType
    185000.00, // price
    '1P9A37699F2H87654', // vin
  ),
  Truck(
    '2',
    'Volvo',
    'VNL 760',
    2021,
    'White',
    210000,
    'Dallas',
    'Texas',
    58000,
    'Diesel',
    'Volvo D13',
    'Automatic',
    160000.00,
    'V9P2Y87655B1C2345',
  ),
  Truck(
    '3',
    'Freightliner',
    'Cascadia',
    2023,
    'Blue',
    75000,
    'Chicago',
    'Illinois',
    62000,
    'Diesel',
    'Detroit DD15',
    'Automatic',
    210000.00,
    '3FV1FGHJ9N2J34567',
  ),
  Truck(
    '4',
    'Kenworth',
    'T680',
    2020,
    'Silver',
    350000,
    'Atlanta',
    'Georgia',
    55000,
    'Diesel',
    'PACCAR MX-13',
    'Manual',
    110000.00,
    'K3W7VBNM2R3P87654',
  ),
  Truck(
    '5',
    'Mack',
    'Anthem',
    2022,
    'Black',
    95000,
    'Seattle',
    'Washington',
    65000,
    'Diesel',
    'Mack MP8',
    'Automatic',
    195000.00,
    'M2K9LPO12C4X98765',
  ),
  Truck(
    '6',
    'International',
    'LT Series',
    2021,
    'Gray',
    180000,
    'Miami',
    'Florida',
    59000,
    'Diesel',
    'Cummins X15',
    'Automatic',
    155000.00,
    'IN7U2QW34P5R67890',
  ),
  Truck(
    '7',
    'Peterbilt',
    '389',
    2019,
    'Green',
    420000,
    'Los Angeles',
    'California',
    63000,
    'Diesel',
    'Cummins X15',
    'Manual',
    98000.00,
    '1P9A37699F2H87655',
  ),
  Truck(
    '8',
    'Volvo',
    'VNL 860',
    2023,
    'Dark Blue',
    60000,
    'Dallas',
    'Texas',
    60000,
    'Diesel',
    'Volvo D13',
    'Automatic',
    220000.00,
    'V9P2Y87655B1C2346',
  ),
  Truck(
    '9',
    'Freightliner',
    'Columbia',
    2018,
    'White',
    510000,
    'Chicago',
    'Illinois',
    56000,
    'Diesel',
    'Detroit DD15',
    'Manual',
    75000.00,
    '3FV1FGHJ9N2J34568',
  ),
  Truck(
    '10',
    'Kenworth',
    'W900L',
    2020,
    'Black',
    280000,
    'Atlanta',
    'Georgia',
    64000,
    'Diesel',
    'PACCAR MX-13',
    'Manual',
    130000.00,
    'K3W7VBNM2R3P87656',
  ),
  Truck(
    '11',
    'Mack',
    'Pinnacle',
    2019,
    'Red',
    310000,
    'Seattle',
    'Washington',
    61000,
    'Diesel',
    'Mack MP8',
    'Automatic',
    105000.00,
    'M2K9LPO12C4X98766',
  ),
  Truck(
    '12',
    'International',
    'LoneStar',
    2023,
    'Custom Chrome',
    45000,
    'Miami',
    'Florida',
    66000,
    'Diesel',
    'Cummins X15',
    'Automatic',
    235000.00,
    'IN7U2QW34P5R67891',
  ),
];
