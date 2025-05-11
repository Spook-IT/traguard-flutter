import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traguard/features/update_legal_data/data/use_cases.dart';
import 'package:traguard/features/update_legal_data/domain/requests.dart';
import 'package:traguard/features/update_legal_data/presentation/loading_legal.dart';
import 'package:traguard/features/update_legal_data/presentation/update_legal_form.dart';
import 'package:traguard/shared/utils/extensions.dart';
import 'package:traguard/shared/widgets/error_retry.dart';

/// This widget represents the screen for updating legal data.
class UpdateLegalDataScreen extends ConsumerStatefulWidget {
  /// Creates a new instance of [UpdateLegalDataScreen].
  const UpdateLegalDataScreen({super.key});

  @override
  ConsumerState<UpdateLegalDataScreen> createState() =>
      _UpdateLegalDataScreenState();
}

class _UpdateLegalDataScreenState extends ConsumerState<UpdateLegalDataScreen> {
  late final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController();
  late final _emailController = TextEditingController();
  late final _phoneController = TextEditingController();

  bool _isSaving = false;
  bool get _canSave =>
      !_isSaving &&
      _nameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _phoneController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();

    _nameController.addListener(_listenTextController);
    _emailController.addListener(_listenTextController);
    _phoneController.addListener(_listenTextController);
  }

  @override
  void dispose() {
    _nameController
      ..removeListener(_listenTextController)
      ..dispose();
    _emailController
      ..removeListener(_listenTextController)
      ..dispose();
    _phoneController
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
      final request = LegalDataInfo(
        fullName: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
      );

      await ref.read(updateLegalDataProvider(info: request).future);
      if (!mounted) return;

      context.showSuccessSnackbar(context.l10n.dataSavedSuccessfully);
      context.pop();
    } on Exception catch (e) {
      if (mounted) {
        context.showErrorSnackbar(
          context.l10n.errorCreatingPlayer(e.toString()),
        );
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

    final asyncData = ref.watch(fetchLegalDataProvider).unwrapPrevious();

    final child = switch (asyncData) {
      AsyncData(:final value) => UpdateLegalForm(
        formKey: _formKey,
        nameController: _nameController..text = value.fullName,
        emailController: _emailController..text = value.email,
        phoneController: _phoneController..text = value.phone,
        isSaving: _isSaving,
        canSave: _canSave,
        onSave: _saveData,
      ),
      AsyncError() => SliverFillRemaining(
        hasScrollBody: false,
        child: ErrorRetry(
          onRetry: () {
            ref.invalidate(fetchLegalDataProvider);
          },
        ),
      ),
      _ => const SliverToBoxAdapter(child: LoadingLegal()),
    };

    return Scaffold(
      appBar: AppBar(title: Text(l10n.legalRepresentitive)),
      body: CustomScrollView(slivers: [child]),
    );
  }
}
