import '../body/presentation_body.dart';
import 'package:flutter/material.dart';



class PresentationPage extends StatelessWidget {
  const PresentationPage({super.key,});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PresentationBody(),
    );
  }
}
