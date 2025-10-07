import 'dart:math';

import 'package:aptapp/authentication/user_repository.dart';
import 'package:aptapp/colors.dart';
import 'package:aptapp/l10n/i18n.dart';
import 'package:aptapp/main.dart';
import 'package:aptapp/mixins/traceable_page_mixin.dart';
import 'package:aptapp/social/bloc/social_bloc.dart';
import 'package:aptapp/theme.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AddContactPage extends StatefulWidget {
  AddContactPage({Key? key}) : super(key: key);

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> with TraceablePageMixin, WidgetsBindingObserver {
  SocialBloc? socialBloc;
  final UserRepository userRepository = KiwiContainer().resolve<UserRepository>();
  bool scannedCode = false;

  @override
  void initState() {
    super.initState();
    socialBloc = BlocProvider.of<SocialBloc>(context);
    // Start listening to lifecycle changes.
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    if (!mounted) {
      return;
    }

    final String scannedUserId = getUserIdFromBarcode(barcodes.barcodes.firstOrNull);
    if (scannedUserId.isNotEmpty && !scannedCode) {
      scannedCode = true;
      socialBloc!.add(AddContactEvent(userId: scannedUserId));
      goBack();
    }
  }

  void goBack() {
    if (context.canBeamBack) {
      context.beamBack();
    } else {
      context.beamToNamed("/contacts");
    }
  }

  String getUserIdFromBarcode(Barcode? barcode) {
    String barcodeValue = barcode?.displayValue ?? "";
    if (!barcodeValue.startsWith(basePath)) {
      return "";
    }
    final List<String> parts = barcodeValue.split("/");
    if (parts.length < 4) {
      return "";
    }
    return parts[parts.length - 1];
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final String qrCode = "$basePath/#/contacts/add/${userRepository.user!.patient!.id}";
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: 0,
            title: Container(),
            bottom: TabBar(
              labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: primaryColor),
              unselectedLabelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: primaryColor),
              indicatorColor: primaryColor,
              tabs: [Tab(text: context.i18n.myCode), Tab(text: context.i18n.scanCode)],
            )),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Center(
                child: ResponsiveBuilder(
                  builder: (context, size) {
                    final double containerWidth = size.isMobile ? width * 0.9 : width * 0.5;
                    return Container(
                      width: containerWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: datatableBorderColor), borderRadius: BorderRadius.circular(8), color: Colors.white),
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                            width: double.infinity,
                            child: Column(
                              children: [
                                SelectableText(
                                  userRepository.user!.patient!.firstName! + " " + userRepository.user!.patient!.lastName!,
                                  style: getBreadCrumbStyle(context),
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  height: min(containerWidth, height - 300),
                                  child: PrettyQrView.data(
                                    data: qrCode,
                                    decoration: const PrettyQrDecoration(
                                      shape: PrettyQrSmoothSymbol(roundFactor: 0, color: primaryColor),
                                      image: PrettyQrDecorationImage(
                                        image: AssetImage('assets/images/icon-qr.png'),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Center(
                                  child: SelectableText(
                                    context.i18n.qrCodeDescription,
                                    style: Theme.of(context).textTheme.bodyLarge!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: ResponsiveBuilder(
                  builder: (context, size) {
                    final double containerWidth = size.isMobile ? width * 0.9 : width * 0.5;
                    return Container(
                      width: containerWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: datatableBorderColor), borderRadius: BorderRadius.circular(8), color: Colors.white),
                            padding: EdgeInsets.all(30),
                            width: double.infinity,
                            child: Column(
                              children: [
                                Container(
                                  height: containerWidth,
                                  child: MobileScanner(
                                    onDetect: _handleBarcode,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Center(
                                  child: SelectableText(
                                    context.i18n.scanCodeDescription,
                                    style: Theme.of(context).textTheme.bodyLarge!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get traceablePageName => "Add Contact Page";
}
