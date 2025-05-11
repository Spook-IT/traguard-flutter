import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traguard/features/update_team_data/data/use_cases.dart';
import 'package:traguard/features/update_team_data/domain/requests.dart';
import 'package:traguard/features/update_team_data/presentation/loading_team.dart';
import 'package:traguard/features/update_team_data/presentation/update_team_form.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/widgets/error_retry.dart';

/// This widget represents the screen for updating legal data.
class UpdateTeamDataScreen extends ConsumerStatefulWidget {
  /// Creates a new instance of [UpdateTeamDataScreen].
  const UpdateTeamDataScreen({super.key});

  @override
  ConsumerState<UpdateTeamDataScreen> createState() =>
      _UpdateTeamDataScreenState();
}

class _UpdateTeamDataScreenState extends ConsumerState<UpdateTeamDataScreen> {
  late final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController();
  late final _emailController = TextEditingController();
  late final _addressController = TextEditingController();

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

    final asyncData = ref.watch(fetchTeamDataProvider).unwrapPrevious();

    final child = switch (asyncData) {
      AsyncData(:final value) => UpdateTeamForm(
        formKey: _formKey,
        nameController: _nameController..text = value.teamName,
        emailController: _emailController..text = value.teamLegalEmail,
        addressController: _addressController..text = value.teamLegalAddress,
        isSaving: _isSaving,
        canSave: _canSave,
        onSave: _saveData,
      ),
      AsyncError() => SliverFillRemaining(
        hasScrollBody: false,
        child: ErrorRetry(
          onRetry: () {
            ref.invalidate(fetchTeamDataProvider);
          },
        ),
      ),
      _ => const SliverToBoxAdapter(child: LoadingTeam()),
    };

    return Scaffold(
      appBar: AppBar(title: Text(l10n.team)),
      body: CustomScrollView(slivers: [child]),
    );
  }
}
