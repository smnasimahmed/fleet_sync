import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/customAppBar.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ConstStrings.notification),
      body: ListView.builder(
        itemCount: 10, // Example count, replace with actual data length
        itemBuilder: (context, index) {
          return ListTile(
            style: ListTileStyle.list,
            leading: Image.asset('assets/icons/bag.png', fit: BoxFit.fill),
            title: Text('Notification ${index + 1}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('This is the detail of notification ${index + 1}.'),
                Text(
                  'Time: ${DateTime.now().subtract(Duration(minutes: index * 5)).toLocal()}',
                ),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle notification tap
            },
          );
        },
      ),
    );
  }
}
