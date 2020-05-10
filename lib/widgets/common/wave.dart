import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class CustomWaveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WaveWidget(
        duration: 1,
        config: CustomConfig(
          gradients: [
            [Colors.orange, const Color(0xEEF44336)],
            [Colors.red[200], const Color(0x77E57373)],
            [Colors.orange, const Color(0x66FF9800)],
            [Colors.yellow[800], const Color(0x55FFEB3B)]
          ],
          durations: [35000, 19440, 10800, 6000],
          heightPercentages: [0.20, 0.23, 0.25, 0.30],
          blur: const MaskFilter.blur(BlurStyle.solid, 2),
          gradientBegin: Alignment.bottomLeft,
          gradientEnd: Alignment.topRight,
        ),
        waveAmplitude: 1.0,
        backgroundColor: Colors.white,
        size: Size(double.maxFinite, 50.0));
  }
}
