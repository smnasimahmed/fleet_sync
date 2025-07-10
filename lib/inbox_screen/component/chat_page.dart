import 'package:fleet_sync/const/const_colours.dart';
import 'package:fleet_sync/const/const_strings.dart';
import 'package:fleet_sync/custom_widgets/custom_elevated_button.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:fleet_sync/models/chat_message_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final Future<List<ChatMessage>> future = fetchChatMessages();

  final myId = 'user123';

  final List<String> menuItam = ['Block', 'Delete', 'Report'];
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: SafeArea(child: _chatInputField(bottomPadding)),
         appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          leading: InkWell(
            radius: 10,
            onTap: Get.back,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 17.0),
              child: SvgPicture.asset('assets/icons/back_button.svg'),
            ),
          ),
          actions: [
            _popMenuIcon(),
          ],
      
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(100),
                  child: Image.asset('assets/images/samuel_johnsons.png'),
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: Customtext(
                  maxLine: 1,
                  title: 'Samuel Johnsons',
                  textSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20,),
          child: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(
                  color: ConstColours.colorGreen,
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final data = snapshot.data ?? [];
                return ListView.builder(
                  reverse: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return _messageBox(data, index);
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  PopupMenuButton<String> _popMenuIcon() {
    return PopupMenuButton<String>(
            icon: SvgPicture.asset('assets/icons/chat_menu.svg'),
            color: ConstColours.gunmetalGray,
            onSelected: (value) {
              //TODO: Handle actions here
              if (value == 'Block') {}
              if (value == 'Delete') {}
              if (value == 'Report') {}
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 'Block',
                    child: Customtext(
                      title: 'Block',
                      textSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  PopupMenuDivider(
                    thickness: 1,
                    color: ConstColours.offWhite,
                  ),
                  PopupMenuItem(value: 'Delete',  child: Customtext(
                      title: 'Delete',
                      textSize: 19,
                      fontWeight: FontWeight.w400,
                    ),),
                  PopupMenuDivider(
                    thickness: 1,
                    color: ConstColours.offWhite,
                  ),
                  PopupMenuItem(value: 'Report',  child: Customtext(
                      title: 'Report',
                      textSize: 19,
                      fontWeight: FontWeight.w400,
                    ),),
                ],
          );
  }

  Widget _chatInputField(double bottomPadding) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: bottomPadding+10 ,
        top: 10,
      ),
      child: SizedBox(
        height: 56,
        child: TextFormField(
          controller: textController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: customElevatedButton(
              top: 12,
              right: 11,
              bottom: 12,
              title: ConstStrings.send,
              onPressed: () {
                print(textController.text.runtimeType);
              },
              height: 32,
              width: 78,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset('assets/icons/image.svg'),
            ),
          ),
        ),
      ),
    );
  }

  Column _messageBox(List<ChatMessage> data, int index) {
    return Column(
      crossAxisAlignment:
          (data[index].senderId == myId)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color:
                (data[index].senderId == myId)
                    ? ConstColours.gray
                    : ConstColours.colorGreen,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 257,
          child: Text(data[index].message),
        ),
        Customtext(
          title:
              '${data[index].timestamp.hour}:${data[index].timestamp.minute}',
          textSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
