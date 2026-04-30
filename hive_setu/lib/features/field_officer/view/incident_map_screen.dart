import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_header.dart';

class IncidentMapScreen extends StatefulWidget {
  const IncidentMapScreen({super.key});

  @override
  State<IncidentMapScreen> createState() => _IncidentMapScreenState();
}

class _IncidentMapScreenState extends State<IncidentMapScreen> {
  String _filter = 'All';

  static final _incidents = [
    _Incident(title: 'Varroa Mite Outbreak', location: 'Shamli Block', type: 'Disease', severity: 'High', time: '2 hrs ago', lat: 29.44, lng: 77.32),
    _Incident(title: 'Low Colony Strength', location: 'Meerut Block', type: 'Health', severity: 'Medium', time: '5 hrs ago', lat: 28.98, lng: 77.70),
    _Incident(title: 'Pesticide Exposure', location: 'Saharanpur', type: 'Chemical', severity: 'High', time: '1 day ago', lat: 29.97, lng: 77.55),
    _Incident(title: 'Colony Absconding', location: 'Bijnor', type: 'Behavioral', severity: 'Low', time: '2 days ago', lat: 29.37, lng: 78.14),
    _Incident(title: 'Wax Moth Infestation', location: 'Moradabad', type: 'Disease', severity: 'Medium', time: '3 days ago', lat: 28.84, lng: 78.78),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _filter == 'All' ? _incidents : _incidents.where((i) => i.severity == _filter).toList();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(title: 'Incident Map', subtitle: 'घटना मानचित्र'),
      body: Column(children: [
        // Map placeholder
        Container(
          height: 220,
          margin: const EdgeInsets.all(AppSpacing.screenPaddingH),
          decoration: BoxDecoration(
            color: AppColors.govtTeal.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            boxShadow: AppColors.ambientShadow,
          ),
          child: Stack(children: [
            Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.map_rounded, size: 48, color: AppColors.govtTeal),
              const SizedBox(height: AppSpacing.sm),
              Text('Interactive Map', style: AppTextStyles.titleSmall.copyWith(color: AppColors.govtTeal)),
              Text('Western UP Region', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
            ])),
            // Incident dots overlay
            ..._incidents.map((inc) {
              final color = inc.severity == 'High' ? AppColors.error : inc.severity == 'Medium' ? AppColors.primary : AppColors.secondary;
              return Positioned(
                left: ((inc.lng - 77.0) / 2.0 * 200).clamp(20, 280),
                top: ((30.0 - inc.lat) / 2.0 * 180).clamp(10, 190),
                child: Container(width: 14, height: 14, decoration: BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 6)])),
              );
            }),
          ]),
        ),
        // Severity filter
        SizedBox(
          height: 44,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
            children: ['All', 'High', 'Medium', 'Low'].map((f) {
              final isActive = _filter == f;
              final color = f == 'High' ? AppColors.error : f == 'Medium' ? AppColors.primary : f == 'Low' ? AppColors.secondary : AppColors.govtTeal;
              return Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: GestureDetector(
                  onTap: () => setState(() => _filter = f),
                  child: Chip(label: Text(f, style: AppTextStyles.labelSmall.copyWith(color: isActive ? AppColors.white : color)), backgroundColor: isActive ? color : color.withValues(alpha: 0.1), side: BorderSide.none),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
          child: Text('${filtered.length} incidents', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
        ),
        const SizedBox(height: AppSpacing.sm),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
            itemCount: filtered.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (_, i) => _IncidentCard(incident: filtered[i], onTap: () => context.push(AppRoutes.incidentDetail)),
          ),
        ),
      ]),
    );
  }
}

class _Incident {
  const _Incident({required this.title, required this.location, required this.type, required this.severity, required this.time, required this.lat, required this.lng});
  final String title, location, type, severity, time;
  final double lat, lng;
}

class _IncidentCard extends StatelessWidget {
  const _IncidentCard({required this.incident, required this.onTap});
  final _Incident incident;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = incident.severity == 'High' ? AppColors.error : incident.severity == 'Medium' ? AppColors.primary : AppColors.secondary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
        child: Row(children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
            child: Icon(Icons.warning_amber_rounded, color: color, size: 22)),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(incident.title, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700)),
            Text('📍 ${incident.location} • ${incident.time}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
              child: Text(incident.severity, style: AppTextStyles.labelSmall.copyWith(color: color, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 2),
            Text(incident.type, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          ]),
        ]),
      ),
    );
  }
}
