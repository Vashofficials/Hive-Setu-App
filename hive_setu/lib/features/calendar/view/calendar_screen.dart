import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_header.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focused = DateTime.now();
  DateTime? _selected;

  static final _events = {
    '2026-04-15': ['Hive Inspection — H-03', 'Sugar Syrup Feed'],
    '2026-04-18': ['Honey Extraction — H-04,05'],
    '2026-04-22': ['Queen Check — All Hives'],
    '2026-04-28': ['Migration to Mustard Fields'],
  };

  List<String> _eventsForDate(DateTime d) {
    final key = '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')}';
    return _events[key] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(_focused.year, _focused.month + 1, 0).day;
    final firstWeekday = DateTime(_focused.year, _focused.month, 1).weekday % 7;
    final selEvents = _selected != null ? _eventsForDate(_selected!) : <String>[];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Activity Calendar',
        subtitle: 'गतिविधि कैलेंडर',
        actions: [
          IconButton(icon: const Icon(Icons.add_rounded), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Month Navigator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left_rounded),
                  onPressed: () => setState(() => _focused = DateTime(_focused.year, _focused.month - 1)),
                ),
                Text(
                  _monthName(_focused.month) + ' ${_focused.year}',
                  style: AppTextStyles.titleLarge.copyWith(color: AppColors.onSurface),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right_rounded),
                  onPressed: () => setState(() => _focused = DateTime(_focused.year, _focused.month + 1)),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            // Day headers
            Row(
              children: ['S','M','T','W','T','F','S']
                  .map((d) => Expanded(
                        child: Center(
                          child: Text(d, style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant)),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: AppSpacing.sm),
            // Days grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, childAspectRatio: 1.0),
              itemCount: firstWeekday + daysInMonth,
              itemBuilder: (context, index) {
                if (index < firstWeekday) return const SizedBox();
                final day = index - firstWeekday + 1;
                final date = DateTime(_focused.year, _focused.month, day);
                final hasEvent = _eventsForDate(date).isNotEmpty;
                final isToday = date.year == DateTime.now().year &&
                    date.month == DateTime.now().month &&
                    date.day == DateTime.now().day;
                final isSelected = _selected?.day == day &&
                    _selected?.month == _focused.month &&
                    _selected?.year == _focused.year;
                return GestureDetector(
                  onTap: () => setState(() => _selected = date),
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : isToday
                              ? AppColors.primaryContainer.withValues(alpha: 0.2)
                              : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$day',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: isSelected
                                ? AppColors.white
                                : isToday
                                    ? AppColors.primary
                                    : AppColors.onSurface,
                            fontWeight: isSelected || isToday ? FontWeight.w700 : FontWeight.w400,
                          ),
                        ),
                        if (hasEvent)
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.white : AppColors.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.xl),
            if (_selected != null) ...[
              Text(
                '${_selected!.day} ${_monthName(_selected!.month)} — Events',
                style: AppTextStyles.sectionTitle,
              ),
              const SizedBox(height: AppSpacing.md),
              if (selEvents.isEmpty)
                Text('No events scheduled', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant))
              else
                ...selEvents.map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                          boxShadow: AppColors.ambientShadow,
                        ),
                        child: Row(
                          children: [
                            Container(width: 4, height: 36, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(child: Text(e, style: AppTextStyles.bodyMedium)),
                          ],
                        ),
                      ),
                    )),
            ],
          ],
        ),
      ),
    );
  }

  String _monthName(int m) => ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][m-1];
}
