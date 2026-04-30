import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_input.dart';

class ShippingDetailsScreen extends StatefulWidget {
  const ShippingDetailsScreen({super.key});

  @override
  State<ShippingDetailsScreen> createState() => _ShippingDetailsScreenState();
}

class _ShippingDetailsScreenState extends State<ShippingDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _companyCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _pinCtrl = TextEditingController();
  final _gstCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _companyCtrl.dispose();
    _addressCtrl.dispose();
    _cityCtrl.dispose();
    _pinCtrl.dispose();
    _gstCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(title: 'Shipping Details', subtitle: 'शिपिंग विवरण'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Progress indicator
            Row(children: [
              _StepDot(label: 'Cart', active: true, done: true),
              _StepLine(done: true),
              _StepDot(label: 'Shipping', active: true, done: false),
              _StepLine(done: false),
              _StepDot(label: 'Payment', active: false, done: false),
              _StepLine(done: false),
              _StepDot(label: 'Confirm', active: false, done: false),
            ]),
            const SizedBox(height: AppSpacing.xxxl),
            AppInput(label: 'Contact Name / संपर्क नाम', hint: 'Rajesh Kumar', controller: _nameCtrl, validator: (v) => v == null || v.isEmpty ? 'Required' : null),
            const SizedBox(height: AppSpacing.lg),
            AppInput(label: 'Company / Business Name', hint: 'Kumar Honey Trading', controller: _companyCtrl),
            const SizedBox(height: AppSpacing.lg),
            AppInput(label: 'GSTIN (Optional)', hint: '22AAAAA0000A1Z5', controller: _gstCtrl, textInputAction: TextInputAction.next),
            const SizedBox(height: AppSpacing.lg),
            AppInput(label: 'Shipping Address / पता', hint: 'Full address with landmark', controller: _addressCtrl, maxLines: 3, validator: (v) => v == null || v.isEmpty ? 'Required' : null),
            const SizedBox(height: AppSpacing.lg),
            Row(children: [
              Expanded(child: AppInput(label: 'City / शहर', hint: 'Delhi', controller: _cityCtrl)),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: AppInput(label: 'PIN Code', hint: '110001', controller: _pinCtrl, keyboardType: TextInputType.number)),
            ]),
            const SizedBox(height: AppSpacing.huge),
            AppButton(
              label: 'Continue to Payment',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.push(AppRoutes.payment);
                }
              },
              width: double.infinity,
            ),
            const SizedBox(height: AppSpacing.xxl),
          ]),
        ),
      ),
    );
  }
}

class _StepDot extends StatelessWidget {
  const _StepDot({required this.label, required this.active, required this.done});
  final String label;
  final bool active, done;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 28, height: 28,
        decoration: BoxDecoration(
          color: done ? AppColors.secondary : active ? AppColors.buyerBlue : AppColors.surfaceVariant,
          shape: BoxShape.circle,
        ),
        child: Center(child: done
          ? const Icon(Icons.check_rounded, color: AppColors.white, size: 16)
          : Text(active ? '●' : '○', style: TextStyle(color: active ? AppColors.white : AppColors.onSurfaceVariant, fontSize: 10)),
        ),
      ),
      const SizedBox(height: 4),
      Text(label, style: AppTextStyles.caption.copyWith(color: active ? AppColors.onSurface : AppColors.onSurfaceVariant)),
    ]);
  }
}

class _StepLine extends StatelessWidget {
  const _StepLine({required this.done});
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(height: 2, margin: const EdgeInsets.only(bottom: 18), color: done ? AppColors.secondary : AppColors.surfaceVariant),
    );
  }
}
