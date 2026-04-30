import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_input.dart';

class BulkEnquiryScreen extends StatefulWidget {
  const BulkEnquiryScreen({super.key});

  @override
  State<BulkEnquiryScreen> createState() => _BulkEnquiryScreenState();
}

class _BulkEnquiryScreenState extends State<BulkEnquiryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _companyController = TextEditingController();
  final _qtyController = TextEditingController();
  final _requirementsController = TextEditingController();
  final _contactController = TextEditingController();
  String _selectedProduct = 'Wild Forest Honey';
  String _selectedFpo = 'Any FPO';
  bool _isSubmitting = false;
  bool _submitted = false;

  @override
  void dispose() {
    _companyController.dispose();
    _qtyController.dispose();
    _requirementsController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  static const _products = ['Wild Forest Honey', 'Mustard Honey', 'Acacia Honey', 'Jamun Honey', 'Beeswax', 'Propolis', 'Royal Jelly'];
  static const _fpos = ['Any FPO', 'Sundarbans FPO', 'Muzaffarnagar FPO', 'Almora Beekeepers', 'Haryana FPO', 'Bihar Beekeepers'];

  @override
  Widget build(BuildContext context) {
    if (_submitted) return _buildSuccessScreen(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Bulk Enquiry', subtitle: 'थोक खरीद'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.buyerBlue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  border: Border.all(color: AppColors.buyerBlue.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    const Text('📋', style: TextStyle(fontSize: 24)),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        'Submit your bulk requirement and FPOs will respond within 24 hours.',
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.buyerBlue),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              AppInput(
                label: 'Company / Business Name',
                hint: 'e.g. Sharma Organics Pvt Ltd',
                controller: _companyController,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: AppSpacing.lg),

              Text('Product Required', style: AppTextStyles.inputLabel.copyWith(color: AppColors.onSurface)),
              const SizedBox(height: AppSpacing.xs),
              _DropField(
                value: _selectedProduct,
                items: _products,
                onChanged: (v) => setState(() => _selectedProduct = v!),
              ),
              const SizedBox(height: AppSpacing.lg),

              Text('Preferred FPO', style: AppTextStyles.inputLabel.copyWith(color: AppColors.onSurface)),
              const SizedBox(height: AppSpacing.xs),
              _DropField(
                value: _selectedFpo,
                items: _fpos,
                onChanged: (v) => setState(() => _selectedFpo = v!),
              ),
              const SizedBox(height: AppSpacing.lg),

              AppInput(
                label: 'Quantity Required (kg)',
                hint: 'e.g. 500',
                controller: _qtyController,
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                textInputAction: TextInputAction.next,
                prefixIcon: const Icon(Icons.scale_outlined, size: AppSpacing.iconSm, color: AppColors.onSurfaceVariant),
              ),
              const SizedBox(height: AppSpacing.lg),

              AppInput(
                label: 'Quality Requirements',
                hint: 'Grade, moisture content, certifications needed...',
                controller: _requirementsController,
                maxLines: 3,
                minLines: 3,
              ),
              const SizedBox(height: AppSpacing.lg),

              AppInput(
                label: 'Contact Number',
                hint: '10-digit mobile number',
                controller: _contactController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                validator: (v) => v == null || v.length != 10 ? 'Enter valid number' : null,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 4),
                  child: Text('🇮🇳 +91', style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              AppButton(
                label: 'Submit Enquiry',
                onPressed: _isSubmitting ? null : _submit,
                isLoading: _isSubmitting,
                width: double.infinity,
                icon: const Icon(Icons.send_rounded, color: AppColors.white, size: 18),
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) setState(() { _isSubmitting = false; _submitted = true; });
  }

  Widget _buildSuccessScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('✅', style: TextStyle(fontSize: 72)),
              const SizedBox(height: AppSpacing.xl),
              Text('Enquiry Submitted!', style: AppTextStyles.headlineSmall.copyWith(color: AppColors.onSurface)),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Your bulk enquiry has been sent to $_selectedFpo. Expect a response within 24 hours.',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.huge),
              AppButton(
                label: 'Back to Home',
                onPressed: () => Navigator.pop(context),
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DropField extends StatelessWidget {
  const _DropField({required this.value, required this.items, required this.onChanged});
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<String>(
        value: value,
        items: items.map((s) => DropdownMenuItem(value: s, child: Text(s, style: AppTextStyles.bodyMedium))).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusMd), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusMd), borderSide: BorderSide.none),
        ),
      );
}
