// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:geo_app/Client/Models/User/user_model.dart';
import 'package:geo_app/Page/LandingPage/Profile/components/profile_widget.dart';
import 'package:geo_app/Page/LandingPage/landing_page_interactions.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:geo_app/Page/utilities/dialogs.dart';
import 'package:geo_app/components/header.dart';
import 'package:geo_app/components/qr_code.dart';
import 'package:geo_app/components/qr_code_scanner.dart';

class ProfileQR extends StatelessWidget with LandingPageInteractions {
  ProfileQR({super.key, required this.userid});
  final String userid;

  scanQR(context) async {
    try {
      String friendId = await showQrCodeScanner();
      UserModel? friend = await addFriend(friendId);
      if (friend == null) {
        throw Exception("Friend is null");
      }
      await showSuccessDialog(context, "Friend Request Send");
    } catch (err) {
      print(err);
      await showFailDialog(context, "Couldn't Send the Friend Request");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProfileWidget(
      name: "QR Code",
      prefixIcon: Icons.qr_code_scanner,
      onTap: () {
        final size = MediaQuery.of(context).size;
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Constants.darkBluishGreyColor,
          builder: (_) => Column(
            children: [
              const Spacer(),
              QRCode(
                qrSize: size.width * .9,
                qrPadding: 2,
                qrData: userid,
                qrBackgroundColor: Colors.transparent,
                qrForegroundColor: Constants.primaryColor,
              ),
              const Spacer(),
              InkWell(
                onTap: () => scanQR(context),
                child: SizedBox(
                  height: 60,
                  child: Row(
                    children: const [
                      Spacer(),
                      Icon(Icons.qr_code_scanner_rounded, color: Colors.white),
                      Header(title: "Scan", color: Colors.white),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
