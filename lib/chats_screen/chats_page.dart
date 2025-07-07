import 'package:fleet_sync/const/const_colours.dart';
import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_formField.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/models/inbox_message_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsPage extends StatelessWidget {
  ChatsPage({super.key});

  final RxBool isSelected = true.obs;
  final RxInt tab = 0.obs;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: ConstColours.colorGreen,
          labelColor: ConstColours.colorGreen,
          onTap: (value) => tab.value = value,
          tabs: [
            Tab(
              child: Customtext(
                title: ConstStrings.inbox,
                textSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Tab(
              child: Customtext(
                title: ConstStrings.requests,
                textSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            // SliverPadding(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   sliver: SliverAppBar(
            //     surfaceTintColor: Colors.transparent,

            //     flexibleSpace: _tabName(),
            //     toolbarHeight: 30,
            //     pinned: true,
            //   ),
            // ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverAppBar(
                surfaceTintColor: Colors.transparent,
                floating: true,
                toolbarHeight: 80,
                flexibleSpace: CustomTextFormField(
                  title: '',
                  hintText: ConstStrings.searchHere,
                  fieldType: FieldType.search,
                ),
              ),
            ),
            Obx(
              () =>
                  (tab.value == 0)
                      ? tabItem(isRequestTab: false)
                      : tabItem(isRequestTab: true), // tabItem()
            ),
          ],
        ),
      ),
    );
  }

  Widget tabItem({bool isRequestTab = false}) {
    return FutureBuilder(
      //
      future:
          fetchInboxMessages(), //TODO: Need to add Abstraction Data types to pass 2 diffrent types
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Transform.scale(
              scaleX: .09,
              scaleY: .06,
              child: CircularProgressIndicator(
                strokeWidth: 50,
                color: ConstColours.colorGreen,
              ),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: Text('No Data')),
          );
        } else if (snapshot.hasError) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: Text('Error ${snapshot.error}')),
          );
        } else {
          final data =
              snapshot.data!
                  .where((test) => test.isRequest == isRequestTab)
                  .toList();
          return _buildiNbox(data);
        }
      },
    );
  }

  SliverList _buildiNbox(List<InboxMessage> data) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final item = data[index];
        return _requestAndiNboxListTile(item);
      }, childCount: data.length),
    );
  }

  ListTile _requestAndiNboxListTile(InboxMessage item) {
    return ListTile(
      style: ListTileStyle.list,
      leading: CircleAvatar(
        radius: 18.95,
        child: Image.asset('assets/images/person_image1.png'),
      ),
      title: Customtext(
        maxLine: 1,
        title: item.senderName,
        textColor: TextColor.colorGreen,
        textSize: 16,
        fontWeight: FontWeight.w600,
      ),
      subtitle: Customtext(
        maxLine: 1,
        title: item.lastMessage,
        textColor: TextColor.colorOffWhite,
      ),
      trailing: (tab == 0) ? _inboxTrailing() : _requestTrailing(),
    );
  }

  Wrap _requestTrailing() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.horizontal,
      spacing: 6,
      children: [
        customElevatedButton(
          horizontal: 10,
          title: ConstStrings.accept,
          fontWeight: FontWeight.w400,
          fontSize: 12,
          onPressed: null,
          width: 67,
          height: 25,
        ),
        customElevatedButton(
          horizontal: 10,
          title: ConstStrings.decline,
          fontWeight: FontWeight.w400,
          fontSize: 12,
          onPressed: null,
          width: 67,
          height: 25,
          color: Colors.red,
        ),
      ],
    );
  }

  Wrap _inboxTrailing() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      direction: Axis.vertical,
      spacing: 6,
      children: [
        CircleAvatar(
          radius: 7.2,
          child: Customtext(title: '2', textSize: 10),
          backgroundColor: ConstColours.red,
        ),
        Customtext(
          title: '01:42',
          fontPoppins: true,
          textColor: TextColor.colorGray,
        ),
      ],
    );
  }

  // SliverList(
  //         delegate: SliverChildBuilderDelegate(
  //           (context, index) {
  //             final item = data[index];
  //             return ListTile(
  //               style: ListTileStyle.list,
  //               leading: CircleAvatar(
  //                 radius: 18.95,
  //                 child: Image.asset('assets/images/person_image1.png'),
  //               ),
  //               title: Customtext(
  //                 title: item.senderName,
  //                 textColor: TextColor.colorGreen,
  //                 textSize: 16,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //               subtitle: Customtext(
  //                 title: item.lastMessage,
  //                 textColor: TextColor.colorOffWhite,
  //               ),
  //             );
  //           },
  //           childCount: data.length,
  //         ),
  //       );

  // ListView.builder(
  //             shrinkWrap: true,
  //             itemCount: data.length,
  //             itemBuilder: (context, index) {
  //               final item = data[index];
  //               return ListTile(
  //                 style: ListTileStyle.list,
  //                 leading: CircleAvatar(
  //                   radius: 18.95,
  //                   child: Image.asset('assets/images/person_image1.png'),
  //                 ),
  //                 title: Customtext(
  //                   title: item.senderName,
  //                   textColor: TextColor.colorGreen,
  //                   textSize: 16,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //                 subtitle: Customtext(
  //                   title: item.lastMessage,
  //                   textColor: TextColor.colorOffWhite,
  //                 ),
  //               );
  //             },
  //           );
  Widget _tabName() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            child: Customtext(
              title: ConstStrings.inbox,
              textSize: 18,
              fontWeight: FontWeight.w600,
              textColor:
                  isSelected.value
                      ? TextColor.colorGreen
                      : TextColor.colorOffWhite,
            ),
            onTap: () {
              if (tab.value == 1) {
                isSelected.value = true;
                tab.value = 0;
              }
            },
          ),

          GestureDetector(
            child: Customtext(
              title: ConstStrings.requests,
              textSize: 18,
              fontWeight: FontWeight.w600,
              textColor:
                  isSelected.value
                      ? TextColor.colorOffWhite
                      : TextColor.colorGreen,
            ),
            onTap: () {
              if (tab.value == 0) {
                isSelected.value = false;
                tab.value = 1;
              }
            },
          ),
        ],
      ),
    );
  }
}
