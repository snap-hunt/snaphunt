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
            [Colors.orange[200], Color(0xEEF44336)],
            [Colors.orange[400], Color(0x77E57373)],
            [Colors.yellow[700], Color(0x66FF9800)],
            [Colors.yellow[9000], Color(0x55FFEB3B)]
          ],
          durations: [35000, 19440, 10800, 6000],
          heightPercentages: [0.20, 0.23, 0.25, 0.30],
          blur: MaskFilter.blur(BlurStyle.inner, 0),
          gradientBegin: Alignment.centerLeft,
          gradientEnd: Alignment.centerRight,
        ),
        waveAmplitude: 1.0,
        backgroundColor: Colors.white,
        size: Size(double.infinity, 50.0));
  }
}
