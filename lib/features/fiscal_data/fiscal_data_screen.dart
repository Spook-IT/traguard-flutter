import 'package:flutter/material.dart';

/// A widget that represents the screen for displaying fiscal data.
class FiscalDataScreen extends StatelessWidget {
  /// Creates a new instance of [FiscalDataScreen].
  const FiscalDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fiscal Data')),
      body: const Center(child: Text('Fiscal Data Screen')),
    );
  }
}
