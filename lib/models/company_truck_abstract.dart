import 'package:fleet_sync/models/comapany_models.dart';
import 'package:fleet_sync/models/fuel_card_models.dart';
import 'package:fleet_sync/models/truck_models.dart';

abstract class FeedItem {
  // Common fields
  String get title;
  String get location;

  // For Company
  String? get companyRatings => null;
  int? get numberOfReviews => null;
  String? get imageUrl => null;

  // For Truck
  String? get id => null;
  String? get brandName => null;
  String? get modelName => null;
  int? get year => null;
  String? get color => null;
  int? get mileage => null;
  String? get cityName => null;
  String? get stateName => null;
  int? get cargoCapacityLbs => null;
  String? get fuelType => null;
  String? get engineType => null;
  String? get transmissionType => null;
  double? get price => null;
  String? get vin => null;
}

Future<List<FeedItem>> getFeedItems() async {
  final trucks = await TruckModels().getTruckData();
  final companies = await CompanyModels().getCompanyData();
  final fuelCards = await FuelCardModels().getFuelCardData();
  return [...trucks, ...companies, ...fuelCards];
}

