import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:snaphunt/main.dart';
import 'package:snaphunt/stores/hunt_model.dart';

IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw ArgumentError('Unknown lens direction');
}

void _showCameraException(CameraException e) {
  print(e.description);
}

String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

// class CameraScreen extends StatefulWidget {
//   @override
//   _CameraScreenState createState() {
//     return _CameraScreenState();
//   }
// }

// class _CameraScreenState extends State<CameraScreen>
//     with WidgetsBindingObserver {
//   CameraController controller;
//   List cameras;
//   int selectedCameraIdx;
//   String imagePath;

//   @override
//   void initState() {
//     super.initState();
//     availableCameras().then((availableCameras) {
//       cameras = availableCameras;

//       if (cameras.length > 0) {
//         setState(() {
//           selectedCameraIdx = 0;
//         });

//         _initCameraController(cameras[selectedCameraIdx]).then((void v) {});
//       } else {
//         print("No camera available");
//       }
//     }).catchError((err) {
//       print('Error: $err.code\nError Message: $err.message');
//     });
//   }

//   Future _initCameraController(CameraDescription cameraDescription) async {
//     if (controller != null) {
//       await controller.dispose();
//     }

//     controller = CameraController(cameraDescription, ResolutionPreset.high);

//     // If the controller is updated then update the UI.
//     controller.addListener(() {
//       if (mounted) {
//         setState(() {});
//       }

//       if (controller.value.hasError) {
//         print('Camera error ${controller.value.errorDescription}');
//       }
//     });

//     try {
//       await controller.initialize();
//     } on CameraException catch (e) {
//       _showCameraException(e);
//     }

//     if (mounted) {
//       setState(() {});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               Expanded(
//                 flex: 1,
//                 child: _cameraPreviewWidget(),
//               ),
//               SizedBox(height: 10.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   _cameraTogglesRowWidget(),
//                   _captureControlRowWidget(context),
//                   Spacer()
//                 ],
//               ),
//               SizedBox(height: 20.0)
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Display Camera preview.
//   Widget _cameraPreviewWidget() {
//     if (controller == null || !controller.value.isInitialized) {
//       return const Text(
//         'Loading',
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 20.0,
//           fontWeight: FontWeight.w900,
//         ),
//       );
//     }

//     return AspectRatio(
//       aspectRatio: controller.value.aspectRatio,
//       child: CameraPreview(controller),
//     );
//   }

//   /// Display the control bar with buttons to take pictures
//   Widget _captureControlRowWidget(context) {
//     return Expanded(
//       child: Align(
//         alignment: Alignment.center,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             FloatingActionButton(
//                 child: Icon(Icons.camera),
//                 backgroundColor: Colors.blueGrey,
//                 onPressed: () {
//                   _onCapturePressed(context);
//                 })
//           ],
//         ),
//       ),
//     );
//   }

//   /// Display a row of toggle to select the camera (or a message if no camera is available).
//   Widget _cameraTogglesRowWidget() {
//     if (cameras == null || cameras.isEmpty) {
//       return Spacer();
//     }

//     CameraDescription selectedCamera = cameras[selectedCameraIdx];
//     CameraLensDirection lensDirection = selectedCamera.lensDirection;

//     return Expanded(
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: FlatButton.icon(
//             onPressed: _onSwitchCamera,
//             icon: Icon(_getCameraLensIcon(lensDirection)),
//             label: Text(
//                 "${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1)}")),
//       ),
//     );
//   }

//   IconData _getCameraLensIcon(CameraLensDirection direction) {
//     switch (direction) {
//       case CameraLensDirection.back:
//         return Icons.camera_rear;
//       case CameraLensDirection.front:
//         return Icons.camera_front;
//       case CameraLensDirection.external:
//         return Icons.camera;
//       default:
//         return Icons.device_unknown;
//     }
//   }

//   void _onSwitchCamera() {
//     selectedCameraIdx =
//         selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1 : 0;
//     CameraDescription selectedCamera = cameras[selectedCameraIdx];
//     _initCameraController(selectedCamera);
//   }

//   void _onCapturePressed(context) async {
//     // Take the Picture in a try / catch block. If anything goes wrong,
//     // catch the error.
//     try {
//       // Attempt to take a picture and log where it's been saved
//       final path = join(
//         // In this example, store the picture in the temp directory. Find
//         // the temp directory using the `path_provider` plugin.
//         (await getTemporaryDirectory()).path,
//         '${DateTime.now()}.png',
//       );
//       print(path);
//       await controller.takePicture(path);

//       // If the picture was taken, display it on a new screen
//     } catch (e) {
//       // If an error occurs, log the error to the console.
//       print(e);
//     }
//   }

//   void _showCameraException(CameraException e) {
//     String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
//     print(errorText);

//     print('Error: ${e.code}\n${e.description}');
//   }
// }

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
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
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
            height: double.infinity,
            width: double.infinity,
            child: _cameraPreviewWidget(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CameraRow(controller: controller),
          ),
          // _captureControlRowWidget(),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[_cameraTogglesRowWidgetT()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }

  Widget _cameraTogglesRowWidgetT() {
    if (cameras == null || cameras.isEmpty) {
      return Spacer();
    }

    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: FlatButton.icon(
            onPressed: _onSwitchCamera,
            icon: Icon(Icons.switch_camera),
            label: Text(
                "${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1)}")),
      ),
    );
  }

  void _onSwitchCamera() {
    selectedCameraIdx =
        selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    onNewCameraSelected(selectedCamera);
    // _initCameraController(selectedCamera);
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
    );

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }
}

class CameraRow extends StatelessWidget {
  final CameraController controller;

  const CameraRow({
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
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.black.withOpacity(0.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            onTap: () async {
              model.onCameraPressed(await onCapturePressed());
            },
            child: const CameraButton(),
          )
        ],
      ),
    );
  }
}

class CameraButton extends StatelessWidget {
  const CameraButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      height: 70,
      width: 70,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
      ),
    );
  }
}
