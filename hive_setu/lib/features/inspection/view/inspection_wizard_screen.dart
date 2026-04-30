import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_input.dart';

class InspectionWizardScreen extends StatefulWidget {
  const InspectionWizardScreen({super.key, this.hiveId = ''});
  final String hiveId;

  @override
  State<InspectionWizardScreen> createState() => _InspectionWizardScreenState();
}

class _InspectionWizardScreenState extends State<InspectionWizardScreen> {
  int _step = 0;
  bool _isSaving = false;

  // Step 1 — Queen, Brood, Food
  String _queenStatus = 'Active';
  String _broodPattern = 'Good';
  double _foodStores = 0.6;
  final _notesController1 = TextEditingController();

  // Step 2 — Pests & Diseases
  bool _varroaPresent = false;
  bool _foulbroodPresent = false;
  bool _nosemaPresent = false;
  bool _smallBeetlePresent = false;
  String _overallHealth = 'Good';

  // Step 3 — Actions & Photos
  final List<String> _actions = [];
  final _actionController = TextEditingController();
  int _photosAdded = 0;
  bool _saveOffline = true;

  @override
  void dispose() {
    _notesController1.dispose();
    _actionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildProgressBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
                child: [_buildStep1, _buildStep2, _buildStep3][_step](),
              ),
            ),
            _buildNavButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH, vertical: AppSpacing.md),
      color: AppColors.surface,
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
              child: const Icon(Icons.close_rounded, size: 18, color: AppColors.onSurface),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Inspection Wizard', style: AppTextStyles.titleMedium),
                Text(widget.hiveId.isNotEmpty ? 'Hive ${widget.hiveId}' : 'New Inspection', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Text('Step ${_step + 1} of 3', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      height: 4,
      color: AppColors.surfaceVariant,
      child: FractionallySizedBox(
        widthFactor: (_step + 1) / 3,
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: const BoxDecoration(gradient: AppColors.pollenPillGradient),
        ),
      ),
    );
  }

  Widget _buildNavButtons() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      color: AppColors.surface,
      child: Row(
        children: [
          if (_step > 0)
            Expanded(
              child: AppButton(
                label: 'Back',
                variant: AppButtonVariant.nest,
                onPressed: () => setState(() => _step--),
              ),
            ),
          if (_step > 0) const SizedBox(width: AppSpacing.md),
          Expanded(
            flex: 2,
            child: _step < 2
                ? AppButton(
                    label: 'Next',
                    onPressed: () => setState(() => _step++),
                    trailing: const Icon(Icons.arrow_forward_rounded, color: AppColors.white, size: 18),
                  )
                : AppButton(
                    label: _saveOffline ? 'Save Offline' : 'Sync Now',
                    onPressed: _isSaving ? null : _save,
                    isLoading: _isSaving,
                    icon: Icon(_saveOffline ? Icons.save_outlined : Icons.sync_rounded, color: AppColors.white, size: 18),
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) {
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_saveOffline ? 'Inspection saved offline' : 'Inspection synced'),
          backgroundColor: AppColors.secondary,
        ),
      );
    }
  }

  // ── Step 1: Queen, Brood, Food ───────────────────────────────────────────

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.sm),
        _StepTitle(icon: '👑', title: 'Queen, Brood & Food', subtitle: 'Check colony health status'),
        const SizedBox(height: AppSpacing.xl),

        Text('Queen Status', style: AppTextStyles.sectionTitle),
        const SizedBox(height: AppSpacing.md),
        _OptionChips(
          options: const ['Active', 'Weak', 'Not Found', 'New Queen'],
          selected: _queenStatus,
          onSelect: (v) => setState(() => _queenStatus = v),
          colors: const {
            'Active': AppColors.secondary,
            'Weak': AppColors.amberAlert,
            'Not Found': AppColors.error,
            'New Queen': AppColors.govtTeal,
          },
        ),

        const SizedBox(height: AppSpacing.xl),
        Text('Brood Pattern', style: AppTextStyles.sectionTitle),
        const SizedBox(height: AppSpacing.md),
        _OptionChips(
          options: const ['Excellent', 'Good', 'Spotty', 'Absent'],
          selected: _broodPattern,
          onSelect: (v) => setState(() => _broodPattern = v),
          colors: const {
            'Excellent': AppColors.secondary,
            'Good': AppColors.secondary,
            'Spotty': AppColors.amberAlert,
            'Absent': AppColors.error,
          },
        ),

        const SizedBox(height: AppSpacing.xl),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Food Stores', style: AppTextStyles.sectionTitle),
            Text('${(_foodStores * 100).round()}%', style: AppTextStyles.labelLarge.copyWith(
              color: _foodStores > 0.5 ? AppColors.secondary : AppColors.amberAlert,
            )),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: AppColors.surfaceVariant,
            thumbColor: AppColors.primaryContainer,
            overlayColor: AppColors.primaryContainer.withValues(alpha: 0.1),
          ),
          child: Slider(
            value: _foodStores,
            onChanged: (v) => setState(() => _foodStores = v),
            divisions: 10,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Empty', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
            Text('Full', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),
        AppInput(
          label: 'Notes (optional)',
          hint: 'Any observations about queen behavior, eggs, larvae...',
          controller: _notesController1,
          maxLines: 3,
          minLines: 3,
        ),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }

  // ── Step 2: Pests & Diseases ─────────────────────────────────────────────

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.sm),
        _StepTitle(icon: '🔬', title: 'Pests & Diseases', subtitle: 'Check for common threats'),
        const SizedBox(height: AppSpacing.xl),

        Text('Pest Indicators', style: AppTextStyles.sectionTitle),
        const SizedBox(height: AppSpacing.md),
        _PestCheckTile(
          name: 'Varroa Mite',
          emoji: '🔴',
          desc: 'Check for mites on bees / sticky board',
          checked: _varroaPresent,
          onChanged: (v) => setState(() => _varroaPresent = v),
        ),
        _PestCheckTile(
          name: 'American Foulbrood',
          emoji: '🟡',
          desc: 'Sunken cappings, ropy test',
          checked: _foulbroodPresent,
          onChanged: (v) => setState(() => _foulbroodPresent = v),
        ),
        _PestCheckTile(
          name: 'Nosema',
          emoji: '🟡',
          desc: 'Dysentery, crawling bees near entrance',
          checked: _nosemaPresent,
          onChanged: (v) => setState(() => _nosemaPresent = v),
        ),
        _PestCheckTile(
          name: 'Small Hive Beetle',
          emoji: '🟠',
          desc: 'Slimey mess, fermentation smell',
          checked: _smallBeetlePresent,
          onChanged: (v) => setState(() => _smallBeetlePresent = v),
        ),

        const SizedBox(height: AppSpacing.xl),
        Text('Overall Colony Health', style: AppTextStyles.sectionTitle),
        const SizedBox(height: AppSpacing.md),
        _OptionChips(
          options: const ['Excellent', 'Good', 'Fair', 'Poor'],
          selected: _overallHealth,
          onSelect: (v) => setState(() => _overallHealth = v),
          colors: const {
            'Excellent': AppColors.secondary,
            'Good': AppColors.secondary,
            'Fair': AppColors.amberAlert,
            'Poor': AppColors.error,
          },
        ),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }

  // ── Step 3: Actions & Photos ─────────────────────────────────────────────

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.sm),
        _StepTitle(icon: '📋', title: 'Actions & Photos', subtitle: 'Record what you did'),
        const SizedBox(height: AppSpacing.xl),

        Text('Actions Taken', style: AppTextStyles.sectionTitle),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: AppInput(
                hint: 'e.g. Added super, fed sugar syrup...',
                controller: _actionController,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            GestureDetector(
              onTap: () {
                if (_actionController.text.trim().isNotEmpty) {
                  setState(() {
                    _actions.add(_actionController.text.trim());
                    _actionController.clear();
                  });
                }
              },
              child: Container(
                width: 48,
                height: 52,
                decoration: BoxDecoration(
                  gradient: AppColors.pollenPillGradient,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: const Icon(Icons.add_rounded, color: AppColors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        if (_actions.isEmpty)
          Text('No actions added yet', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant))
        else
          ..._actions.asMap().entries.map((e) => Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  boxShadow: AppColors.ambientShadow,
                ),
                child: Row(
                  children: [
                    const Text('✅', style: TextStyle(fontSize: 14)),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(child: Text(e.value, style: AppTextStyles.bodySmall)),
                    GestureDetector(
                      onTap: () => setState(() => _actions.removeAt(e.key)),
                      child: const Icon(Icons.close_rounded, size: 16, color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              )),

        const SizedBox(height: AppSpacing.xl),
        Text('Photos', style: AppTextStyles.sectionTitle),
        const SizedBox(height: AppSpacing.md),
        GestureDetector(
          onTap: () => setState(() => _photosAdded++),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              border: Border.all(color: AppColors.outlineVariant, style: BorderStyle.solid),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add_a_photo_outlined, color: AppColors.onSurfaceVariant),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  _photosAdded == 0 ? 'Add Photos' : '$_photosAdded photo(s) added',
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.xl),
        Text('Save Options', style: AppTextStyles.sectionTitle),
        const SizedBox(height: AppSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            boxShadow: AppColors.ambientShadow,
          ),
          child: Column(
            children: [
              _SaveOption(
                icon: Icons.save_outlined,
                title: 'Save Offline',
                subtitle: 'Stored locally, sync when online',
                selected: _saveOffline,
                onTap: () => setState(() => _saveOffline = true),
              ),
              Divider(height: 1, color: AppColors.outlineVariant),
              _SaveOption(
                icon: Icons.sync_rounded,
                title: 'Sync Now',
                subtitle: 'Upload immediately to server',
                selected: !_saveOffline,
                onTap: () => setState(() => _saveOffline = false),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}

// ── Shared sub-widgets ───────────────────────────────────────────────────────

class _StepTitle extends StatelessWidget {
  const _StepTitle({required this.icon, required this.title, required this.subtitle});
  final String icon, title, subtitle;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 32)),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.titleLarge),
              Text(subtitle, style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant)),
            ],
          ),
        ],
      );
}

class _OptionChips extends StatelessWidget {
  const _OptionChips({required this.options, required this.selected, required this.onSelect, this.colors = const {}});
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelect;
  final Map<String, Color> colors;

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: options.map((o) {
          final isSelected = o == selected;
          final color = colors[o] ?? AppColors.primary;
          return GestureDetector(
            onTap: () => onSelect(o),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              decoration: BoxDecoration(
                color: isSelected ? color.withValues(alpha: 0.12) : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                border: Border.all(color: isSelected ? color : AppColors.transparent, width: 1.5),
              ),
              child: Text(
                o,
                style: AppTextStyles.labelMedium.copyWith(
                  color: isSelected ? color : AppColors.onSurface,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      );
}

class _PestCheckTile extends StatelessWidget {
  const _PestCheckTile({required this.name, required this.emoji, required this.desc, required this.checked, required this.onChanged});
  final String name, emoji, desc;
  final bool checked;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onChanged(!checked),
        child: Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: checked ? AppColors.error.withValues(alpha: 0.06) : AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(color: checked ? AppColors.error.withValues(alpha: 0.4) : AppColors.outlineVariant),
          ),
          child: Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTextStyles.titleSmall),
                    Text(desc, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                  ],
                ),
              ),
              Checkbox(
                value: checked,
                onChanged: (v) => onChanged(v ?? false),
                activeColor: AppColors.error,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
            ],
          ),
        ),
      );
}

class _SaveOption extends StatelessWidget {
  const _SaveOption({required this.icon, required this.title, required this.subtitle, required this.selected, required this.onTap});
  final IconData icon;
  final String title, subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary.withValues(alpha: 0.1) : AppColors.surfaceVariant,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: selected ? AppColors.primary : AppColors.onSurfaceVariant, size: AppSpacing.iconSm),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.titleSmall),
                    Text(subtitle, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                  ],
                ),
              ),
              if (selected) const Icon(Icons.radio_button_checked_rounded, color: AppColors.primary),
              if (!selected) const Icon(Icons.radio_button_unchecked_rounded, color: AppColors.onSurfaceVariant),
            ],
          ),
        ),
      );
}
