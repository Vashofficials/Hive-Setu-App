import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_input.dart';

class FieldVisitLogScreen extends StatefulWidget {
  const FieldVisitLogScreen({super.key});

  @override
  State<FieldVisitLogScreen> createState() => _FieldVisitLogScreenState();
}

class _FieldVisitLogScreenState extends State<FieldVisitLogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _locationCtrl = TextEditingController();
  final _purposeCtrl = TextEditingController();
  final _observationsCtrl = TextEditingController();
  final _actionCtrl = TextEditingController();
  bool _gpsLogged = false;
  bool _submitted = false;

  @override
  void dispose() {
    _locationCtrl.dispose();
    _purposeCtrl.dispose();
    _observationsCtrl.dispose();
    _actionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(title: 'Field Visit Log', subtitle: 'फील्ड विजिट लॉग'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: _submitted ? _buildSuccess() : _buildForm(),
      ),
    );
  }

  Widget _buildSuccess() {
    return Column(children: [
      const SizedBox(height: AppSpacing.massive),
      Container(width: 80, height: 80, decoration: BoxDecoration(color: AppColors.secondary.withValues(alpha: 0.1), shape: BoxShape.circle),
        child: const Icon(Icons.check_circle_rounded, color: AppColors.secondary, size: 48)),
      const SizedBox(height: AppSpacing.xxl),
      Text('Visit Logged! ✅', style: AppTextStyles.headlineSmall.copyWith(color: AppColors.onSurface)),
      const SizedBox(height: AppSpacing.sm),
      Text('Your field visit has been recorded successfully.', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant), textAlign: TextAlign.center),
      const SizedBox(height: AppSpacing.xxxl),
      AppButton(label: 'Back to Planner', onPressed: () => Navigator.pop(context), width: double.infinity),
    ]);
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // GPS Card
        GestureDetector(
          onTap: () => setState(() => _gpsLogged = true),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: _gpsLogged ? AppColors.secondary.withValues(alpha: 0.06) : AppColors.govtTeal.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            ),
            child: Row(children: [
              Container(width: 48, height: 48, decoration: BoxDecoration(color: (_gpsLogged ? AppColors.secondary : AppColors.govtTeal).withValues(alpha: 0.15), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
                child: Icon(_gpsLogged ? Icons.check_circle_rounded : Icons.gps_fixed_rounded, color: _gpsLogged ? AppColors.secondary : AppColors.govtTeal, size: 24)),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(_gpsLogged ? 'GPS Location Captured' : 'Tap to Log GPS Location', style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700, color: _gpsLogged ? AppColors.secondary : AppColors.govtTeal)),
                Text(_gpsLogged ? '29.4401°N, 77.3186°E' : 'Required for visit verification', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
              ])),
            ]),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),

        AppInput(label: 'Visit Location / स्थान', hint: 'e.g. Shamli Block, Village Khatoli', controller: _locationCtrl, validator: (v) => v == null || v.isEmpty ? 'Required' : null),
        const SizedBox(height: AppSpacing.lg),
        AppInput(label: 'Purpose of Visit / उद्देश्य', hint: 'e.g. Disease assessment, scheme verification', controller: _purposeCtrl, validator: (v) => v == null || v.isEmpty ? 'Required' : null),
        const SizedBox(height: AppSpacing.lg),
        AppInput(label: 'Observations / अवलोकन', hint: 'Describe what you observed during the visit...', controller: _observationsCtrl, maxLines: 4),
        const SizedBox(height: AppSpacing.lg),
        AppInput(label: 'Actions Taken / की गई कार्रवाई', hint: 'Treatment recommended, follow-up needed...', controller: _actionCtrl, maxLines: 3),
        const SizedBox(height: AppSpacing.lg),

        // Photo capture
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
          child: Row(children: [
            Container(width: 48, height: 48, decoration: BoxDecoration(color: AppColors.govtTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
              child: const Icon(Icons.camera_alt_rounded, color: AppColors.govtTeal, size: 24)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Attach Photos', style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w600)),
              Text('Add evidence photos from the visit', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
            ])),
            const Icon(Icons.add_a_photo_rounded, color: AppColors.govtTeal),
          ]),
        ),
        const SizedBox(height: AppSpacing.huge),

        AppButton(
          label: 'Submit Visit Log',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              setState(() => _submitted = true);
            }
          },
          width: double.infinity,
        ),
        const SizedBox(height: AppSpacing.xxl),
      ]),
    );
  }
}
