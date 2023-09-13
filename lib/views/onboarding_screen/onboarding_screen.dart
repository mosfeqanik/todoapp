import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/note/note_provider.dart';
import '../../utils/appstrings.dart';
import '../../utils/local_storage_manager.dart';
import '../../utils/shared_pref_keys.dart';
import '../../widget/custom_button.dart';
import '../note_screens/notes_page.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Flexible(
              child: Hero(
                tag: 'keep',
                child: Icon(
                  Icons.edit_note_sharp,
                  size: 120,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            const Hero(
              tag: 'Note',
              child: Text(
                AppStrings.appName,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 26,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 40.0),
                child: Text(
                  AppStrings.onboardingDescription,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.white),
                )),
            CustomButton(
              onpress: () async {
                LocalStorageManager.saveData(
                    SharedPrefStrings.isOnboardingShowed, true);
                Provider.of<NoteProvider>(context, listen: false)
                    .refreshNotes();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const NotesPage(),
                  ),
                  (route) => false,
                );
              },
              text: AppStrings.next,
              accentColor: Colors.white,
              mainColor: Colors.black45,
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
