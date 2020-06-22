import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:snaphunt/constants/app_theme.dart';
import 'package:snaphunt/widgets/common/fancy_button.dart';

import 'package:flutter/services.dart';

class JoinRoom extends StatelessWidget {
  Future<String> scanQR() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = null;
    } catch (ex) {
      barcodeScanRes = null;
    }
    return barcodeScanRes;
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      elevation: 5,
      title: Center(
        child: Text(
          'Enter Room Code',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            DialogCardTextField(controller: controller),
            const SizedBox(height: 15),
            DialogFancyButton(
              text: 'Join Room',
              color: Colors.deepOrangeAccent,
              onPressed: () {
                final code = controller.text;
                if (code != null && code.isNotEmpty) {
                  Navigator.of(context).pop(code);
                }
              },
            ),
            const SizedBox(height: 10),
            const DividerDialog(),
            const SizedBox(height: 20),
            DialogFancyButton(
              text: 'Scan QR Code',
              color: Colors.orange,
              onPressed: () async {
                final code = await scanQR();
                if (code != null && code != '-1') {
                  Navigator.of(context).pop(code);
                }
              },
            ),
            const SizedBox(height: 15),
            DialogFancyButton(
              text: 'Close',
              color: Colors.blueGrey,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DialogFancyButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const DialogFancyButton({
    Key key,
    this.text,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FancyButton(
      size: 60,
      color: color,
      onPressed: onPressed,
      child: SizedBox(
        width: 150,
        child: Center(
          child: Text(
            text,
            style: fancyButtonStyle,
          ),
        ),
      ),
    );
  }
}

class DialogCardTextField extends StatelessWidget {
  final TextEditingController controller;

  const DialogCardTextField({Key key, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 2.0,
      ),
      height: 65,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 3,
        child: Container(
          width: 300,
          margin: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: controller,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DividerDialog extends StatelessWidget {
  const DividerDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            height: 1,
            color: Colors.blueGrey,
          ),
        ),
        const SizedBox(
          width: 60,
          child: Center(
            child: Text(
              'or',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}
