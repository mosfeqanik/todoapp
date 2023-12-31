import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/local_storage_manager.dart';
import '../../utils/shared_pref_keys.dart';
import '../note_screens/notes_page.dart';
import '../onboarding_screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = true;
  static const CHANNEL = MethodChannel("com.mosfeqanik.todo_app");

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => setPref());
  }

  void setPref() async {
    bool isOnboardingShowed;
    isOnboardingShowed = await LocalStorageManager.readData(
            SharedPrefStrings.isOnboardingShowed) ??
        false;
    // await getMacAddress();
    if (isOnboardingShowed) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const NotesPage()),
          (route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
          (route) => false);
    }
  }

  // Future<String?> getMacAddress() async {
  //   try {
  //     final String mac = await MethodChannel(CHANNEL).invokeMethod('getMac');
  //     return mac;
  //   } on PlatformException catch (e) {
  //     print("Error getting MAC address: ${e.message}");
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Keep',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: 'note',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 150,
              height: 2,
              child: LinearProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
