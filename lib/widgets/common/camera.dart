import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/stores/hunt_model.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController _controller;

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (_controller != null) {
      await _controller.dispose();
    }

    _controller = CameraController(cameraDescription, ResolutionPreset.high);

    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (_controller.value.hasError) {
        print('Camera error ${_controller.value.errorDescription}');
      }
    });

    try {
      await _controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      if (availableCameras.isNotEmpty) {
        _initCameraController(availableCameras.first);
      } else {
        print("No camera available");
      }
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: <Widget>[
        CameraPreview(_controller),
        Align(
          alignment: Alignment.bottomCenter,
          child: CameraButton(
            controller: _controller,
          ),
        )
      ],
    );
  }

  void _showCameraException(CameraException e) {
    String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    print(errorText);

    print('Error: ${e.code}\n${e.description}');
  }
}

class CameraButton extends StatelessWidget {
  final CameraController controller;

  const CameraButton({
    Key key,
    this.controller,
  }) : super(key: key);

  Future<String> onCapturePressed() async {
    String _path;

    try {
      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );
      await controller.takePicture(path);
      _path = path;
    } catch (e) {
      print(e);
    }

    return _path;
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HuntModel>(context, listen: false);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.black.withOpacity(0.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            onTap: () async {
              model.onCameraPressed(await onCapturePressed());
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              height: 60,
              width: 60,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey)),
            ),
          )
        ],
      ),
    );
  }
}
