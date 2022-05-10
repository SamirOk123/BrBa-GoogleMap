import 'dart:io';
import 'package:breaking_bad/constants.dart';
import 'package:breaking_bad/views/characters_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'Breaking Bad & Google Map',
          debugShowCheckedModeBanner: false,
          home: CharactersPage(),
          theme: ThemeData(
            colorSchemeSeed: kGreen,
            brightness: Brightness.light,
            useMaterial3: true,
          ),
        );
      },
    );
  }
}
