import 'package:fleet_sync/models/company_truck_abstract.dart';

class FuelCard extends FeedItem {
  String idValue;
  String cardNameValue;
  String cityValue;
  String stateValue;
  double ratingValue;
  int numberOfReviewsValue;
  String imageUrlValue;

  FuelCard(
    this.idValue,
    this.cardNameValue,
    this.cityValue,
    this.stateValue,
    this.ratingValue,
    this.numberOfReviewsValue,
    this.imageUrlValue,
  );

  @override
  String get title => cardNameValue;

  @override
  String get location => '$cityValue, $stateValue';

  @override
  String? get companyRatings => ratingValue.toString();

  @override
  int? get numberOfReviews => numberOfReviewsValue;

  @override
  String? get imageUrl => imageUrlValue;

  @override
  String? get id => idValue;

  @override
  String? get cityName => cityValue;

  @override
  String? get stateName => stateValue;
}

class FeedFuelCardModels {
  Future<List<FeedItem>> getFeedFuelCardData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return fuelCards;
  }
}

class FuelCardModels {
  Future<List<FuelCard>> getFuelCardData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return fuelCards;
  }
}

List<FuelCard> fuelCards = [
  FuelCard(
    'fc1',
    'FuelFast Plus Card',
    'Los Angeles',
    'California',
    4.6,
    65,
    'assets/images/fuel_fast_card.png',
  ),
  FuelCard(
    'fc2',
    'EcoFuel Rewards',
    'Chicago',
    'Illinois',
    4.4,
    80,
    'assets/images/eco_fuel_rewards.png',
  ),
  FuelCard(
    'fc3',
    'TurboFuel Cashback',
    'Houston',
    'Texas',
    4.7,
    120,
    'assets/images/turbo_fuel_cashback.png',
  ),
  FuelCard(
    'fc4',
    'FleetFuel Saver',
    'Miami',
    'Florida',
    4.5,
    95,
    'assets/images/fleet_fuel_saver.png',
  ),
];
