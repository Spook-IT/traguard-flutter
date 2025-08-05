import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:traguard/features/session_management/domain/session_manager.dart';
import 'package:traguard/shared/providers/connected_devices.dart';
import 'package:traguard/shared/router/routes.dart';
import 'package:traguard/shared/utils/extensions.dart';

class NewSessionScreen extends ConsumerStatefulWidget {
  const NewSessionScreen({super.key});

  @override
  ConsumerState<NewSessionScreen> createState() => _NewSessionScreenState();
}

class _NewSessionScreenState extends ConsumerState<NewSessionScreen> {
  final _fields = ['Campo A', 'Campo B'];
  String? _selectedField;
  final Map<BluetoothDevice, TextEditingController> _controllers = {};
  final Map<BluetoothDevice, bool> _selected = {};

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final devices = ref.watch(connectedDevicesProvider).devices;
    for (final d in devices) {
      _controllers.putIfAbsent(d, () => TextEditingController());
      _selected.putIfAbsent(d, () => false);
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Nuova sessione')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<String>(
            value: _selectedField,
            hint: const Text('Seleziona campo'),
            items: _fields
                .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                .toList(),
            onChanged: (v) => setState(() => _selectedField = v),
          ),
          const SizedBox(height: 16),
          ...devices.map(
            (d) => CheckboxListTile(
              value: _selected[d],
              onChanged: (v) => setState(() => _selected[d] = v ?? false),
              title: TextField(
                controller: _controllers[d],
                decoration: InputDecoration(
                  labelText: d.advName.isNotEmpty
                      ? d.advName
                      : d.remoteId.str,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final chosen = devices.where((d) => _selected[d] == true).toList();
              final names = chosen
                  .map((d) => _controllers[d]!.text.isNotEmpty
                      ? _controllers[d]!.text
                      : d.advName)
                  .toList();
              ref
                  .read(sessionManagerProvider.notifier)
                  .startSession(chosen, names);
              const SessionManagementRoute().go(context);
            },
            child: const Text('Avvia sessione'),
          ),
        ],
      ),
    );
  }
}
