import 'package:fleet_sync/models/company_truck_abstract.dart';

class Company extends FeedItem {
  String idValue;
  String nameValue;
  String cityValue;
  String stateValue;
  double ratingValue;
  int numberOfReviewsValue;
  String imageUrlValue;

  Company(
    this.idValue,
    this.nameValue,
    this.cityValue,
    this.stateValue,
    this.ratingValue,
    this.numberOfReviewsValue,
    this.imageUrlValue,
  );

  @override
  String get title => nameValue;

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

class FeedCompanyModels {
  Future<List<FeedItem>> getFeedCompanyData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return companies;
  }
}

class CompanyModels {
  Future<List<Company>> getCompanyData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return companies;
  }
}

List<Company> companies = [
  Company(
    '1', // id
    'Falcon International', // name
    'Los Angeles', // city
    'California', // state
    4.8, // rating
    45, // numberOfReviews
    'assets/images/falcon_international.png', // imageUrl (placeholder, as it's an uploaded image)
  ),
  Company(
    '2',
    'Global Logistics Inc.',
    'Chicago',
    'Illinois',
    4.5,
    120,
    'assets/images/global_logistics.png',
  ),
  Company(
    '3',
    'TransNet Solutions',
    'Houston',
    'Texas',
    4.2,
    88,
    'assets/images/transnet_solutions.png',
  ),
  Company(
    '4',
    'Nationwide Carriers',
    'Atlanta',
    'Georgia',
    4.9,
    210,
    'assets/images/nationwide_carriers.png',
  ),
  Company(
    '5',
    'Coastal Freight LLC',
    'Miami',
    'Florida',
    4.7,
    60,
    'assets/images/coastal_freight.png',
  ),
  Company(
    '6',
    'Midwest Haulers',
    'Kansas City',
    'Missouri',
    4.1,
    30,
    'assets/images/midwest_haulers.png',
  ),
  Company(
    '7',
    'Western Star Transport',
    'Denver',
    'Colorado',
    4.6,
    95,
    'assets/images/western_star.png',
  ),
  Company(
    '8',
    'Eastern Express Group',
    'New York',
    'New York',
    4.4,
    150,
    'assets/images/eastern_express.png',
  ),
  Company(
    '9',
    'Pioneer Logistics',
    'Phoenix',
    'Arizona',
    4.3,
    72,
    'assets/images/pioneer_logistics.png',
  ),
  Company(
    '10',
    'Summit Transport Co.',
    'Seattle',
    'Washington',
    4.7,
    110,
    'assets/images/summit_transport.png',
  ),
  Company(
    '11',
    'Great Lakes Freight',
    'Detroit',
    'Michigan',
    4.0,
    40,
    'assets/images/great_lakes_freight.png',
  ),
  Company(
    '12',
    'Southern Haulage',
    'Charlotte',
    'North Carolina',
    4.8,
    180,
    'assets/images/southern_haulage.png',
  ),
];
