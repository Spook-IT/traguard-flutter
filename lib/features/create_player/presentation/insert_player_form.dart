import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traguard/features/create_player/presentation/color_picker_player.dart';
import 'package:traguard/features/player_list_screen/data/use_cases.dart';
import 'package:traguard/shared/models/player.dart';
import 'package:traguard/shared/utils/constants.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/utils/sizes.dart';
import 'package:traguard/shared/widgets/common_menu.dart';

/// A widget that represents a form for inserting a new player.
/// It includes fields for the player's name, number, role, status,
/// and color.
class InsertPlayerForm extends ConsumerStatefulWidget {
  /// Creates a new instance of [InsertPlayerForm].
  const InsertPlayerForm({super.key});

  @override
  ConsumerState<InsertPlayerForm> createState() => _InsertPlayerFormState();
}

class _InsertPlayerFormState extends ConsumerState<InsertPlayerForm> {
  late final _nameController = TextEditingController();
  late final _playerNumberController = TextEditingController();
  PlayerRole? _playerRole;
  PlayerStatus? _playerStatus;
  late int _playerColorHex = chartColors.first.toARGB32();

  late final _formKey = GlobalKey<FormState>();

  final bool _isSaving = false;

  bool get _canSave =>
      !_isSaving &&
      _nameController.text.isNotEmpty &&
      _playerNumberController.text.isNotEmpty &&
      _playerRole != null &&
      _playerStatus != null;

  @override
  void initState() {
    super.initState();

    _nameController.addListener(_listenTextController);
    _playerNumberController.addListener(_listenTextController);
  }

  @override
  void dispose() {
    _nameController
      ..removeListener(_listenTextController)
      ..dispose();
    _playerNumberController
      ..removeListener(_listenTextController)
      ..dispose();

    super.dispose();
  }

  void _savePlayer() {
    if (!_canSave) {
      return;
    }

    final player = Player(
      id: '',
      name: _nameController.text.split(' ')[0],
      surname: _nameController.text.split(' ').sublist(1).join(' '),
      playerNumber: int.tryParse(_playerNumberController.text) ?? 0,
      role: _playerRole ?? PlayerRole.unknown,
      status: _playerStatus ?? PlayerStatus.unknown,
      uiColor: _playerColorHex,
    );
    logger.i('Player created: $player');

    // TODO(dariowskii): save player to database

    ref.invalidate(fetchPlayersProvider);

    // TODO(dariowskii): show snackbar

    context.pop();
  }

  void _listenTextController() {
    setState(() {
      // Trigger a rebuild to update the save button state
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO(dariowskii): add localizations
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: Paddings.largeAll,
        child: Form(
          key: _formKey,
          child: Column(
            spacing: Spaces.medium,
            children: [
              Expanded(
                child: Column(
                  spacing: Spaces.medium,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      enabled: !_isSaving,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [
                        AutofillHints.name,
                        AutofillHints.familyName,
                      ],
                      decoration: InputDecoration(
                        label: const Text('Nome e Cognome*'),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: context.colorScheme.outline.withValues(
                              alpha: .3,
                            ),
                          ),
                        ),
                      ),
                      onTapOutside: (e) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Inserisci il nome e cognome';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _playerNumberController,
                      enabled: !_isSaving,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: const Text('Numero*'),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: context.colorScheme.outline.withValues(
                              alpha: .3,
                            ),
                          ),
                        ),
                        prefix: Text('#', style: context.textTheme.labelLarge),
                      ),
                      onTapOutside: (e) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Inserisci il numero';
                        }
                        return null;
                      },
                    ),
                    CommonMenu(
                      label: Text('${context.l10n.role}*'),
                      initialSelection: null,
                      onSelected: (role) {
                        setState(() {
                          _playerRole = role;
                        });
                      },
                      dropdownMenuEntries:
                          PlayerRole.values
                              .where((role) => role != PlayerRole.unknown)
                              .map((role) {
                                return DropdownMenuEntry(
                                  value: role,
                                  label: role.getLabel(context),
                                );
                              })
                              .toList(),
                    ),
                    CommonMenu(
                      label: Text('${context.l10n.status}*'),
                      initialSelection: null,
                      onSelected: (status) {
                        setState(() {
                          _playerStatus = status;
                        });
                      },
                      dropdownMenuEntries:
                          PlayerStatus.values
                              .where((status) => status != PlayerStatus.unknown)
                              .map((status) {
                                return DropdownMenuEntry(
                                  value: status,
                                  label: status.getLabel(context),
                                );
                              })
                              .toList(),
                    ),
                    ColorPickerPlayer(
                      onColorChanged: (color) {
                        setState(() {
                          _playerColorHex = color.toARGB32();
                        });
                      },
                    ),
                  ],
                ),
              ),
              FilledButton(
                onPressed: _canSave ? _savePlayer : null,
                child: Padding(
                  padding: Paddings.largeHorizontal,
                  child: Text(context.l10n.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
