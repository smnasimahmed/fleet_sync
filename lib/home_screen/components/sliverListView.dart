import 'package:fleet_sync/models/company_truck_abstract.dart';
import 'package:flutter/material.dart';
import 'package:fleet_sync/home_screen/components/popularCompanyCard.dart';

class CustomListview extends StatelessWidget {
  final CardMode cardMode;
  final Future<List<FeedItem>> Function() fetchFeedItems;
  final void Function() onPressed;
  final void Function() bookMarkonTap;
  final void Function()? shareOntap;
  
  const CustomListview({
    super.key,
    required this.cardMode,
    required this.fetchFeedItems,
    required this.onPressed,
    required this.bookMarkonTap,
    this.shareOntap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 228,
        child: FutureBuilder<List<FeedItem>>(
          future: fetchFeedItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            } else {
              final feedItems = snapshot.data!;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: feedItems.length,
                itemBuilder: (context, index) {
                  final item = feedItems[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: PopularCompanyCard(
                      title: item.title,
                      location: item.location,
                      ratings: item.companyRatings ?? '',
                      brand: item.brandName ?? '',
                      model: item.modelName ?? '',
                      cardMode: cardMode,
                      onPressed: onPressed,
                      bookMarkonTap: bookMarkonTap,
                      shareOntap:
                          (cardMode == CardMode.truck) ? shareOntap : null,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
