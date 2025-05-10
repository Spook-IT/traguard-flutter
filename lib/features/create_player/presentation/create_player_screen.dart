import 'package:flutter/material.dart';

/// A widget that represents the screen for creating a new player.
class CreatePlayerScreen extends StatelessWidget {
  /// Creates a new instance of [CreatePlayerScreen].
  const CreatePlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Player')),
      body: const Center(child: Text('Create Player Screen')),
    );
  }
}
