import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traguard/features/update_team_data/data/use_cases.dart';
import 'package:traguard/features/update_team_data/domain/requests.dart';
import 'package:traguard/shared/utils/extensions.dart' hide DurationExtensions;
import 'package:traguard/shared/utils/sizes.dart';
import 'package:traguard/shared/widgets/save_button.dart';

/// This widget represents a form for updating legal data.
/// It includes fields for the user's name, email, and phone number.
/// It also includes a save button that is enabled when all fields are valid.
class UpdateTeamForm extends ConsumerStatefulWidget {
  /// Creates a new instance of [UpdateTeamForm].
  const UpdateTeamForm({required this.initialData, super.key});

  /// The initial data to populate the form fields.
  final TeamDataInfo initialData;

  @override
  ConsumerState<UpdateTeamForm> createState() => _UpdateTeamFormState();
}

class _UpdateTeamFormState extends ConsumerState<UpdateTeamForm> {
  late final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(
    text: widget.initialData.teamName,
  );
  late final _emailController = TextEditingController(
    text: widget.initialData.teamLegalEmail,
  );
  late final _addressController = TextEditingController(
    text: widget.initialData.teamLegalAddress,
  );

  bool _isSaving = false;
  bool get _canSave =>
      !_isSaving &&
      _nameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _addressController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();

    _nameController.addListener(_listenTextController);
    _emailController.addListener(_listenTextController);
    _addressController.addListener(_listenTextController);
  }

  @override
  void dispose() {
    _nameController
      ..removeListener(_listenTextController)
      ..dispose();
    _emailController
      ..removeListener(_listenTextController)
      ..dispose();
    _addressController
      ..removeListener(_listenTextController)
      ..dispose();
    super.dispose();
  }

  void _listenTextController() {
    setState(() {});
  }

  Future<void> _saveData() async {
    if (!_canSave) {
      return;
    }

    if (_formKey.currentState?.validate() != true) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final request = TeamDataInfo(
        teamName: _nameController.text.trim(),
        teamLegalEmail: _emailController.text.trim(),
        teamLegalAddress: _addressController.text.trim(),
      );

      await ref.read(updateTeamDataProvider(info: request).future);
      if (!mounted) return;

      context.showSuccessSnackbar(context.l10n.dataSavedSuccessfully);
      context.pop();
    } on Exception catch (e) {
      if (mounted) {
        context.showErrorSnackbar(context.l10n.errorSavingData(e.toString()));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final delay = 100.ms;
    final moveYDuration = 300.ms;
    const moveYCurve = Curves.decelerate;
    const moveYBegin = 20.0;
    const moveYEnd = 0.0;

    return SliverFillRemaining(
      hasScrollBody: false,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: Paddings.mediumAll,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: Spaces.small,
            children: [
              TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.teamNameEmpty;
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: '${l10n.teamName}*'),
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  )
                  .animate()
                  .moveY(
                    duration: moveYDuration,
                    begin: moveYBegin,
                    end: moveYEnd,
                    curve: moveYCurve,
                  )
                  .fadeIn(),
              TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.l10n.legalEmailEmpty;
                      }

                      if (!value.isValidEmail) {
                        return context.l10n.emailInvalid;
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: '${l10n.legalEmail}*',
                    ),
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  )
                  .animate(delay: delay)
                  .moveY(
                    duration: moveYDuration,
                    begin: moveYBegin,
                    end: moveYEnd,
                    curve: moveYCurve,
                  )
                  .fadeIn(),
              TextFormField(
                    controller: _addressController,
                    keyboardType: TextInputType.phone,
                    autofillHints: const [AutofillHints.fullStreetAddress],
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return l10n.legalAddressEmpty;
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: '${l10n.legalAddress}*',
                    ),
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  )
                  .animate(delay: delay * 2)
                  .moveY(
                    duration: moveYDuration,
                    begin: moveYBegin,
                    end: moveYEnd,
                    curve: moveYCurve,
                  )
                  .fadeIn(),
              const Spacer(),
              SafeArea(
                child: SaveButton(
                      isSaving: _isSaving,
                      canSave: _canSave,
                      onPressed: _saveData,
                    )
                    .animate(delay: delay * 3)
                    .moveY(
                      duration: 750.ms,
                      begin: 100,
                      end: moveYEnd,
                      curve: Curves.easeOutCubic,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
