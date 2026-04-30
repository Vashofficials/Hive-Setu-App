import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class IncidentDetailScreen extends StatefulWidget {
  const IncidentDetailScreen({super.key, required this.incidentId});
  final String incidentId;

  @override
  State<IncidentDetailScreen> createState() => _IncidentDetailScreenState();
}

class _IncidentDetailScreenState extends State<IncidentDetailScreen> {
  String _status = 'Open';
  final _noteController = TextEditingController();
  bool _addingNote = false;

  static const _statusOptions = ['Open', 'Under Investigation', 'Action Taken', 'Resolved'];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Color get _statusColor => switch (_status) {
        'Resolved' => AppColors.secondary,
        'Action Taken' => AppColors.govtTeal,
        'Under Investigation' => AppColors.amberAlert,
        _ => AppColors.error,
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: widget.incidentId,
        subtitle: 'Incident Detail',
        badge: _status,
        badgeColor: _statusColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIncidentCard(),
            const SizedBox(height: AppSpacing.xl),
            _buildStatusControl(),
            const SizedBox(height: AppSpacing.xl),
            Text('Affected Hives', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.md),
            _buildAffectedHives(),
            const SizedBox(height: AppSpacing.xl),
            Text('Field Notes', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.md),
            _buildNotes(),
            const SizedBox(height: AppSpacing.xl),
            Text('Photos', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.md),
            _buildPhotoGrid(),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Add Photo',
                    variant: AppButtonVariant.nest,
                    icon: const Icon(Icons.camera_alt_rounded, color: AppColors.govtTeal, size: 18),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: AppButton(
                    label: 'Save Report',
                    icon: const Icon(Icons.save_rounded, color: AppColors.white, size: 18),
                    onPressed: _saveReport,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildIncidentCard() => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: AppColors.ambientShadow,
          border: Border(left: BorderSide(color: _statusColor, width: 4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('⚠️', style: TextStyle(fontSize: 28)),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Varroa Mite Infestation', style: AppTextStyles.titleMedium),
                      Text('Reported: 29 Apr 2026 • 09:12 AM', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            const Divider(height: 1, color: AppColors.outlineVariant),
            const SizedBox(height: AppSpacing.md),
            _InfoRow(icon: Icons.person_outline_rounded, label: 'Beekeeper', value: 'Ramesh Kumar'),
            _InfoRow(icon: Icons.location_on_outlined, label: 'Location', value: 'Charthawal Farm, Muzaffarnagar'),
            _InfoRow(icon: Icons.hive_rounded, label: 'Apiary', value: 'Charthawal Farm (24 hives)'),
            _InfoRow(icon: Icons.warning_amber_rounded, label: 'Severity', value: 'High — Varroa load > 15%'),
            _InfoRow(icon: Icons.calendar_today_rounded, label: 'FPO', value: 'Muzaffarnagar FPO'),
          ],
        ),
      );

  Widget _buildStatusControl() => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: AppColors.ambientShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Update Status', style: AppTextStyles.titleSmall),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: _statusOptions.map((s) {
                final selected = _status == s;
                final color = switch (s) {
                  'Resolved' => AppColors.secondary,
                  'Action Taken' => AppColors.govtTeal,
                  'Under Investigation' => AppColors.amberAlert,
                  _ => AppColors.error,
                };
                return GestureDetector(
                  onTap: () => setState(() => _status = s),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: selected ? color : color.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                      border: Border.all(color: color.withValues(alpha: selected ? 0 : 0.3)),
                    ),
                    child: Text(s, style: AppTextStyles.labelSmall.copyWith(
                      color: selected ? AppColors.white : color,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );

  Widget _buildAffectedHives() => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: AppColors.ambientShadow,
        ),
        child: Column(
          children: [
            _HiveRow(hiveId: 'H-03', varroa: '18.2%', severity: 'Critical'),
            const Divider(height: AppSpacing.lg, color: AppColors.outlineVariant),
            _HiveRow(hiveId: 'H-07', varroa: '15.8%', severity: 'High'),
            const Divider(height: AppSpacing.lg, color: AppColors.outlineVariant),
            _HiveRow(hiveId: 'H-11', varroa: '12.1%', severity: 'High'),
          ],
        ),
      );

  Widget _buildNotes() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NoteCard(
            author: 'Arjun Sharma (Field Officer)',
            date: '29 Apr 2026, 11:30 AM',
            note: 'Visual inspection confirmed heavy mite load. Recommended oxalic acid treatment. Beekeeper to proceed under FPO supervision.',
            isOwn: true,
          ),
          const SizedBox(height: AppSpacing.sm),
          _NoteCard(
            author: 'FPO Supervisor',
            date: '29 Apr 2026, 02:15 PM',
            note: 'Treatment kit dispatched to beekeeper. Follow-up inspection scheduled in 7 days.',
            isOwn: false,
          ),
          const SizedBox(height: AppSpacing.md),
          if (_addingNote)
            Column(
              children: [
                TextField(
                  controller: _noteController,
                  maxLines: 3,
                  style: AppTextStyles.bodySmall,
                  decoration: InputDecoration(
                    hintText: 'Add field note...',
                    hintStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant),
                    filled: true,
                    fillColor: AppColors.white,
                    contentPadding: const EdgeInsets.all(AppSpacing.md),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      borderSide: const BorderSide(color: AppColors.outlineVariant),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      borderSide: const BorderSide(color: AppColors.outlineVariant),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      borderSide: const BorderSide(color: AppColors.govtTeal),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(child: AppButton(label: 'Cancel', variant: AppButtonVariant.ghost, size: AppButtonSize.small, onPressed: () => setState(() => _addingNote = false))),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(child: AppButton(label: 'Add Note', size: AppButtonSize.small, onPressed: _addNote)),
                  ],
                ),
              ],
            )
          else
            GestureDetector(
              onTap: () => setState(() => _addingNote = true),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.govtTeal.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  border: Border.all(color: AppColors.govtTeal.withValues(alpha: 0.2), style: BorderStyle.solid),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.add_circle_outline_rounded, color: AppColors.govtTeal, size: 18),
                    const SizedBox(width: AppSpacing.sm),
                    Text('Add field note', style: AppTextStyles.bodySmall.copyWith(color: AppColors.govtTeal)),
                  ],
                ),
              ),
            ),
        ],
      );

  Widget _buildPhotoGrid() => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: AppSpacing.sm,
          mainAxisSpacing: AppSpacing.sm,
        ),
        itemCount: 3,
        itemBuilder: (_, i) {
          final emojis = ['🐛', '🔬', '🍯'];
          return Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Center(child: Text(emojis[i], style: const TextStyle(fontSize: 28))),
          );
        },
      );

  void _addNote() {
    if (_noteController.text.trim().isEmpty) return;
    setState(() { _addingNote = false; _noteController.clear(); });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Note added'), backgroundColor: AppColors.govtTeal, behavior: SnackBarBehavior.floating),
    );
  }

  void _saveReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Incident ${widget.incidentId} saved — Status: $_status'), backgroundColor: AppColors.govtTeal, behavior: SnackBarBehavior.floating),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label, value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: AppSpacing.iconSm, color: AppColors.onSurfaceVariant),
            const SizedBox(width: AppSpacing.sm),
            SizedBox(width: 80, child: Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant))),
            Expanded(child: Text(value, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500))),
          ],
        ),
      );
}

class _HiveRow extends StatelessWidget {
  const _HiveRow({required this.hiveId, required this.varroa, required this.severity});
  final String hiveId, varroa, severity;

  Color get _color => severity == 'Critical' ? AppColors.error : AppColors.amberAlert;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          const Text('🐝', style: TextStyle(fontSize: 20)),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hive $hiveId', style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500)),
              Text('Varroa Load: $varroa', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
            ],
          )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            ),
            child: Text(severity, style: AppTextStyles.labelSmall.copyWith(color: _color, fontWeight: FontWeight.w700)),
          ),
        ],
      );
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({required this.author, required this.date, required this.note, required this.isOwn});
  final String author, date, note;
  final bool isOwn;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isOwn ? AppColors.govtTeal.withValues(alpha: 0.06) : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          boxShadow: isOwn ? null : AppColors.ambientShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(author, style: AppTextStyles.caption.copyWith(color: AppColors.govtTeal, fontWeight: FontWeight.w600))),
                Text(date, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
            const SizedBox(height: 4),
            Text(note, style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurface, height: 1.4)),
          ],
        ),
      );
}
