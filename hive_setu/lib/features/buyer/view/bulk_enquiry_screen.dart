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
  final _productCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  String? _selectedProduct;
  bool _isSubmitted = false;

  static const _products = ['Mustard Honey', 'Acacia Honey', 'Jamun Honey', 'Multiflora Honey', 'Beeswax', 'Propolis', 'Royal Jelly', 'Bee Pollen'];

  @override
  void dispose() {
    _productCtrl.dispose();
    _qtyCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(title: 'Bulk Enquiry', subtitle: 'थोक पूछताछ'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: _isSubmitted ? _buildSuccess() : _buildForm(),
      ),
    );
  }

  Widget _buildSuccess() {
    return Column(children: [
      const SizedBox(height: AppSpacing.massive),
      Container(
        width: 80, height: 80,
        decoration: BoxDecoration(color: AppColors.secondary.withValues(alpha: 0.1), shape: BoxShape.circle),
        child: const Icon(Icons.check_circle_rounded, color: AppColors.secondary, size: 48),
      ),
      const SizedBox(height: AppSpacing.xxl),
      Text('Enquiry Submitted!', style: AppTextStyles.headlineSmall.copyWith(color: AppColors.onSurface)),
      const SizedBox(height: AppSpacing.sm),
      Text('We will connect you with suppliers within 24 hours.', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant), textAlign: TextAlign.center),
      const SizedBox(height: AppSpacing.xxxl),
      AppButton(label: 'Submit Another', onPressed: () => setState(() => _isSubmitted = false), width: double.infinity),
    ]);
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(color: AppColors.buyerBlue.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
          child: Row(children: [
            const Icon(Icons.info_outline_rounded, color: AppColors.buyerBlue, size: 20),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: Text('Get competitive quotes from multiple FPOs for large orders (100kg+)', style: AppTextStyles.bodySmall.copyWith(color: AppColors.buyerBlue))),
          ]),
        ),
        const SizedBox(height: AppSpacing.xxl),
        // Product Type
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Product Type / उत्पाद', style: AppTextStyles.inputLabel.copyWith(color: AppColors.onSurface)),
          const SizedBox(height: AppSpacing.xs),
          DropdownButtonFormField<String>(
            value: _selectedProduct,
            hint: Text('Select product', style: AppTextStyles.inputHint.copyWith(color: AppColors.onSurfaceVariant)),
            items: _products.map((p) => DropdownMenuItem(value: p, child: Text(p, style: AppTextStyles.bodyMedium))).toList(),
            onChanged: (v) => setState(() => _selectedProduct = v),
            validator: (v) => v == null ? 'Select a product' : null,
            decoration: InputDecoration(
              filled: true, fillColor: AppColors.surface,
              contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusMd), borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusMd), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusMd), borderSide: BorderSide.none),
            ),
          ),
        ]),
        const SizedBox(height: AppSpacing.lg),
        AppInput(label: 'Quantity Required (kg)', hint: 'e.g. 500', controller: _qtyCtrl, keyboardType: TextInputType.number, validator: (v) => v == null || v.isEmpty ? 'Required' : null),
        const SizedBox(height: AppSpacing.lg),
        AppInput(label: 'Additional Notes / विशेष आवश्यकता', hint: 'Quality, packaging, delivery preferences...', controller: _notesCtrl, maxLines: 4),
        const SizedBox(height: AppSpacing.huge),
        AppButton(
          label: 'Submit Enquiry',
          onPressed: () {
            if (_formKey.currentState!.validate()) setState(() => _isSubmitted = true);
          },
          width: double.infinity,
        ),
      ]),
    );
  }
}
