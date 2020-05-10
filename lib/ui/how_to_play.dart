import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class HowToPlay extends StatelessWidget {
  final List<PageViewModel> pages = [
    PageViewModel(
      pageColor: Colors.amber,
      body: const Text(
        'Modes:\nSINGLEPLAYER or MULTIPLAYER',
        style: TextStyle(
          fontSize: 24,
          height: 1,
        ),
      ),
      title: Text(
        'Select Game Mode',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      textStyle: TextStyle(color: Colors.white),
      mainImage: Image.asset(
        'assets/intro_one.png',
        height: 400,
        width: 400,
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      pageColor: Colors.lightBlue,
      body: const Text(
        'Set TIME LIMIT and NO. OF ITEMS\n\nMultiplayer:\n(ROOM NAME and MAX PLAYERS)',
        style: TextStyle(fontSize: 24, height: 1),
      ),
      title: Text(
        'Set Game Settings',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      textStyle: TextStyle(color: Colors.white),
      mainImage: Image.asset(
        'assets/intro_two.png',
        height: 350,
        width: 350,
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      pageColor: Colors.deepPurple,
      body: const Text(
        'Start the game and look for the items displayed on the screen.',
        style: TextStyle(fontSize: 24, height: 1),
      ),
      title: Text(
        'Begin Hunt',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      textStyle: TextStyle(color: Colors.white),
      mainImage: Image.asset(
        'assets/intro_three.png',
        height: 400,
        width: 400,
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      pageColor: Colors.green,
      body: const Text(
        'Take a snap of the object to be verified.\nEvery point is gained once item is valid.',
        style: TextStyle(fontSize: 26, height: 1),
      ),
      title: Text(
        'Take a Snap',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      textStyle: TextStyle(color: Colors.white),
      mainImage: Image.asset(
        'assets/intro_four.png',
        height: 400,
        width: 400,
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      pageColor: Colors.blueAccent,
      body: const Text(
        'First one to snap all items or with the highest score before the time limit ends wins the game.',
        style: TextStyle(fontSize: 26, height: 1),
      ),
      title: Text(
        'Be The Champion',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      textStyle: TextStyle(color: Colors.white),
      mainImage: Image.asset(
        'assets/intro_five.png',
        height: 400,
        width: 400,
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      pageColor: Colors.red,
      body: const Text(
        'You are now ready to begin your Scavenger Game Hunt!',
        style: TextStyle(fontSize: 26, height: 1),
      ),
      title: Text(
        'Let the Hunt Begin',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      textStyle: TextStyle(color: Colors.white),
      mainImage: Image.asset(
        'assets/intro_six.png',
        height: 320,
        width: 320,
        alignment: Alignment.center,
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: IntroViewsFlutter(
        pages,
        onTapDoneButton: () {
          Navigator.pop(context);
        },
        columnMainAxisAlignment: MainAxisAlignment.center,
        fullTransition: 175,
        showSkipButton: false,
        showNextButton: false,
        pageButtonTextStyles: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
