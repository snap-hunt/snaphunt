import 'dart:async';
import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PictureScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PictureScannerState();
}

class _PictureScannerState extends State<PictureScanner> {
  File _imageFile;
  Size _imageSize;
  dynamic _scanResults;

  final ImageLabeler _imageLabeler = FirebaseVision.instance.imageLabeler();

  Future<void> _getAndScanImage() async {
    setState(() {
      _imageFile = null;
      _imageSize = null;
    });

    final File imageFile =
        await ImagePicker.pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      _getImageSize(imageFile);
      _scanImage(imageFile);
    }

    setState(() {
      _imageFile = imageFile;
    });
  }

  Future<void> _getImageSize(File imageFile) async {
    final Completer<Size> completer = Completer<Size>();

    final Image image = Image.file(imageFile);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    final Size imageSize = await completer.future;
    setState(() {
      _imageSize = imageSize;
    });
  }

  Future<void> _scanImage(File imageFile) async {
    setState(() {
      _scanResults = null;
    });

    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);

    dynamic results;

    results = await _imageLabeler.processImage(visionImage);

    setState(() {
      _scanResults = results;
    });
  }

  Widget _buildImage(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(maxHeight: mq.size.height * 0.6),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.file(_imageFile).image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          if (_imageSize == null || _scanResults == null)
            const Center(
              child: Text(
                'Scanning...',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            )
          else
            Expanded(
              child: ListView(
                children: <Widget>[
                  for (var image in _scanResults)
                    Text('${image.confidence} - ${image.text}')
                ],
              ),
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Container(
        child: _imageFile == null
            ? const Center(child: Text('No image selected.'))
            : _buildImage(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getAndScanImage,
        child: Icon(Icons.camera),
      ),
    );
  }

  @override
  void dispose() {
    _imageLabeler.close();
    super.dispose();
  }
}
