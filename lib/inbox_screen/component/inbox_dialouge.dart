import 'package:fleet_sync/const/const_colours.dart';
import 'package:fleet_sync/custom_widgets/custom_text.dart';
import 'package:flutter/material.dart';

Future<void> showAcceptDeclineDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        backgroundColor: ConstColours.appDarktBackGround, // dark background
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/person_image2.png'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Customtext(
                      title: 'John Doe',
                      textColor: TextColor.colorGreen,
                      fontWeight: FontWeight.w600,
                      textSize: 18,
                    ),
                
                    SizedBox(height: 4),
                    Flexible(
                      child: Customtext(
                        title: 'Hellow! Thanks for reaching out!',
                        textColor: TextColor.colorOffWhite,
                        fontWeight: FontWeight.w400,
                        textSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _acceptButton(context),
                        SizedBox(width: 12),
                        _declineButton(context),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _declineButton(BuildContext context) {
  return SizedBox(
    height: 30,
    child: ElevatedButton(
      onPressed: () {
        // handle decline
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(
        // minimumSize: Size(20, 10),
        backgroundColor: ConstColours.gray,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      // child: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Customtext(
          title: 'Decline',
          textColor: TextColor.colorWhite,
          fontWeight: FontWeight.w400,
          textSize: 14,
        ),
      // ),
    ),
  );
}

Widget _acceptButton(BuildContext context) {
  return SizedBox(
    height: 30,
    child: ElevatedButton(
      onPressed: () {
        // handle accept
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(
              // minimumSize: Size(20, 10),
        backgroundColor: ConstColours.colorGreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      // child: Padding(
        // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Customtext(
          title: 'Accept',
          textColor: TextColor.colorWhite,
          fontWeight: FontWeight.w400,
          textSize: 14,
        ),
      // ),
    ),
  );
}
