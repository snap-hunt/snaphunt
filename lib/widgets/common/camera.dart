import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/main.dart';
import 'package:snaphunt/stores/hunt_model.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController controller;
  String imagePath;
  int selectedCameraIdx = 0;

  @override
  void initState() {
    super.initState();
    onNewCameraSelected(cameras[selectedCameraIdx]);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(cameras[selectedCameraIdx]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.black,
            width: double.infinity,
            height: double.infinity,
            child: controller != null && controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: CameraPreview(controller),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CameraRow(
              controller: controller,
              onCameraSwitch: _onSwitchCamera,
            ),
          ),
        ],
      ),
    );
  }

  void _onSwitchCamera() {
    selectedCameraIdx =
        selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1 : 0;
    onNewCameraSelected(cameras[selectedCameraIdx]);
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }

    controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
    );

    controller.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      print(e.description);
    }

    if (mounted) {
      setState(() {});
    }
  }
}

class CameraRow extends StatelessWidget {
  final CameraController controller;
  final VoidCallback onCameraSwitch;

  const CameraRow({
    Key key,
    this.controller,
    this.onCameraSwitch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.4),
      height: 100,
      child: Stack(
        children: <Widget>[
          Align(
            child: CameraButton(controller: controller),
          ),
          Positioned(
            height: 100,
            left: MediaQuery.of(context).size.width * 0.75,
            child: CameraSwapButton(
              onPressed: onCameraSwitch,
            ),
          )
        ],
      ),
    );
  }
}

class CameraSwapButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CameraSwapButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 1,
          color: Colors.white,
        ),
      ),
      child: IconButton(
        icon: Icon(
          Icons.switch_camera,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
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
    return InkWell(
      onTap: () async {
        model.onCameraPressed(await onCapturePressed());
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.deepOrange,
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
