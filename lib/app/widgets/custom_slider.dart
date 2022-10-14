import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/loan_model.dart';

enum SliderType { loan, period }

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    Key? key,
    this.sliderType = SliderType.loan,
    required this.value,
    required this.label,
    required this.divisions,
    required this.onPress,
  }) : super(key: key);

  final SliderType sliderType;
  final double value;
  final String label;
  final List<String> divisions;
  final void Function(dynamic) onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: VStack([
        Container(
          color: const Color(0xFFF0F0F0),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(0),
          child: HStack([
            RawMaterialButton(
              onPressed: () {
                double newValue = value - 1;
                if (newValue >= 0) {
                  onPress(newValue);
                }
              },
              fillColor: Colors.white,
              padding: const EdgeInsets.all(15.0),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.remove,
                size: 16.0,
                color: Color(0xFF1F46A1),
              ),
            ),
            const Spacer(),
            label.text
                .size(24)
                .bold
                .color(const Color(0xFF1F46A1))
                .overflow(TextOverflow.ellipsis)
                .make(),
            const Spacer(),
            RawMaterialButton(
              onPressed: () {
                double newValue = value + 1;
                if (newValue <= divisions.length) {
                  onPress(newValue);
                }
              },
              fillColor: Colors.white,
              padding: const EdgeInsets.all(15.0),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.add,
                size: 16.0,
                color: Color(0xFF1F46A1),
              ),
            ),
          ]),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SliderTheme(
            data: const SliderThemeData(
              trackHeight: 8,
              thumbColor: Colors.white,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 16),
            ),
            child: Slider(
              min: 0,
              max: divisions.length.toDouble() - 1.0,
              divisions: divisions.length - 1,
              value: value,
              onChanged: onPress,
              inactiveColor: Colors.black12,
              activeColor: const Color(0xFF1F46A1),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(divisions.length, (index) {
              return divisions[index]
                  .text
                  .color(const Color(0xFF1F46A1))
                  .make();
            }),
          ),
        ),
      ]),
    );
  }
}
