import 'package:fleet_sync/const/const_colours.dart';
import 'package:fleet_sync/home_screen/components/popularCompanyCard.dart';
import 'package:flutter/material.dart';
// TODO: Import or define ConstColours, CardMode, and PopularCompanyCard if not already done.

class CustomGridView<T> extends StatelessWidget {
  final Future<T> fetchFeedItems;
  // final Widget Function(List<dynamic>) gridViewBuilder;
  final CardMode cardMode;
  final void Function() onPressed;

  const CustomGridView({
    super.key,
    required this.fetchFeedItems,
    // required this.gridViewBuilder,
    required this.cardMode,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double baseWidth = 375;
    double scale = screenWidth / baseWidth;
    scale = scale.clamp(0.9, 1.15);
    int crossAxisCount = screenWidth > 450 ? 4 : 2;

    return FutureBuilder<T>(
      future: fetchFeedItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: ConstColours.colorGreen,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          final feedItems = snapshot.data ?? [];
          return _gridView(feedItems, scale, crossAxisCount);
        }
      },
    );
  }

  Widget _gridView(feedItems, scale, crossAxisCount) {
    //List<FeedItem>
    return GridView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 30),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: feedItems.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 14,
        crossAxisSpacing: 0,
        childAspectRatio: .75, //0.77,
      ),
      itemBuilder: (context, index) {
        final item = feedItems[index];
        return Center(
          child: Transform.scale(
            scale: scale, //1.1,
            child: PopularCompanyCard(
              title: item.title,
              location: item.location,
              cardMode: cardMode, //CardMode.truck,
              model: item.modelName ?? '',
              brand: item.brandName ?? '',
              onPressed: onPressed,
              bookMarkonTap: () {},
            ),
          ),
        );
      },
    );
  }
}
