import 'package:example/ui/appbars/back_button_appbar/back_appbar.dart';
import 'package:example/ui/appbars/basic_appbar/basic_appbar.dart';
import 'package:example/ui/buttons/icon_outlined_button/iconOutlined_button.dart';
import 'package:example/ui/buttons/outlined_button/outlined_button.dart';
import 'package:example/ui/buttons/primary_button/primary_button.dart';
import 'package:example/ui/cards/image_card/image_card.dart';
import 'package:example/ui/cards/modern_card/modern_card.dart';
import 'package:example/ui/inputfields/leading_text_inputfield/leading_inputfield.dart';
import 'package:example/ui/inputfields/password_text_inputfield/password_inputfield.dart';
import 'package:example/ui/inputfields/primary_text_inputfield/primary_inputfield.dart';
import 'package:example/ui/inputfields/singlechar_text_inputfield/singlechar_inputfield.dart';
import 'package:flutter/material.dart';
import 'package:example/ui/buttons/icon_button/icon_button.dart';

class ExampleView extends StatelessWidget {
  const ExampleView({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return Scaffold(
      appBar: BasicAppBar(
        title: "AppBar with Back Button",
      ),
    );
  }
}
