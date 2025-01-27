import 'package:example/ui/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class ExampleView extends StatelessWidget {
  const ExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
    child: PrimaryButton(onPress: () {  },),
      ),
    );
  }
}
