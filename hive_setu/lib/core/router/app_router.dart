import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/view/splash_screen.dart';
import '../../features/language/view/language_screen.dart';
import '../../features/auth/view/phone_login_screen.dart';
import '../../features/auth/view/otp_screen.dart';
import '../../features/profile/view/profile_setup_screen.dart';

// Beekeeper
import '../../features/home/view/home_screen.dart';
import '../../features/apiary/view/apiary_screen.dart';
import '../../features/apiary/view/hive_detail_screen.dart';
import '../../features/hive_products/view/hive_products_screen.dart';
import '../../features/best_practices/view/best_practices_screen.dart';
import '../../features/calendar/view/calendar_screen.dart';
import '../../features/migration/view/migration_screen.dart';
import '../../features/products_sale/view/products_sale_screen.dart';
import '../../features/alert/view/alert_screen.dart';
import '../../features/flora/view/flora_screen.dart';
import '../../features/camera/view/camera_screen.dart';
import '../../features/location/view/location_screen.dart';
import '../../features/bee_health/view/bee_health_screen.dart';
import '../../features/chat_support/view/chat_support_screen.dart';
import '../../features/beekeeper_profile/view/beekeeper_profile_screen.dart';
import '../../features/more/view/more_screen.dart';
import '../../features/settings/view/settings_screen.dart';
import '../../features/inspection/view/inspection_wizard_screen.dart';
import '../../features/finance/view/finance_screen.dart';

// Honey Collector
import '../../features/wild_harvest/view/harvest_log_screen.dart';
import '../../features/wild_harvest/view/geotag_camera_screen.dart';
import '../../features/wild_harvest/view/harvest_detail_screen.dart';
import '../../features/wild_harvest/view/fpo_submit_screen.dart';
import '../../features/wild_harvest/view/digital_id_screen.dart';

// Buyer
import '../../features/buyer/view/buyer_home_screen.dart';
import '../../features/buyer/view/product_categories_screen.dart';
import '../../features/buyer/view/cart_screen.dart';
import '../../features/buyer/view/orders_screen.dart';
import '../../features/buyer/view/order_detail_screen.dart';
import '../../features/buyer/view/bulk_enquiry_screen.dart';
import '../../features/marketplace/view/marketplace_screen.dart';
import '../../features/marketplace/view/product_detail_screen.dart';
import '../../features/marketplace/view/checkout_screen.dart';

// FPO Admin
import '../../features/fpo_admin/view/fpo_dashboard_screen.dart';
import '../../features/fpo_admin/view/fpo_members_screen.dart';
import '../../features/fpo_admin/view/fpo_member_detail_screen.dart';
import '../../features/fpo_admin/view/fpo_approval_screen.dart';
import '../../features/fpo_admin/view/fpo_broadcast_screen.dart';
import '../../features/fpo_admin/view/fpo_stock_screen.dart';
import '../../features/fpo_admin/view/fpo_reports_screen.dart';

// Field Officer
import '../../features/field_officer/view/field_officer_home_screen.dart';
import '../../features/field_officer/view/field_officer_alerts_screen.dart';
import '../../features/field_officer/view/field_officer_map_screen.dart';
import '../../features/field_officer/view/incident_detail_screen.dart';
import '../../features/field_officer/view/field_visit_screen.dart';
import '../../features/field_officer/view/scheme_screen.dart';

class AppRoutes {
  // Onboarding
  static const splash = '/';
  static const language = '/language';
  static const phoneLogin = '/login';
  static const otp = '/otp';
  static const profileSetup = '/profile-setup';

  // Beekeeper
  static const home = '/home';
  static const apiary = '/apiary';
  static const hiveDetail = '/hive-detail';
  static const hiveProducts = '/hive-products';
  static const bestPractices = '/best-practices';
  static const calendar = '/calendar';
  static const migration = '/migration';
  static const productsSale = '/products-sale';
  static const alert = '/alert';
  static const flora = '/flora';
  static const camera = '/camera';
  static const location = '/location';
  static const beeHealth = '/bee-health';
  static const chatSupport = '/chat-support';
  static const beekeeperProfile = '/beekeeper-profile';
  static const more = '/more';
  static const settings = '/settings';
  static const inspectionWizard = '/inspection-wizard';
  static const finance = '/finance';

  // Honey Collector
  static const harvestLog = '/harvest-log';
  static const geotagCamera = '/geotag-camera';
  static const harvestDetail = '/harvest-detail';
  static const fpoSubmit = '/fpo-submit';
  static const digitalId = '/digital-id';

  // Buyer
  static const buyerHome = '/buyer-home';
  static const productCategories = '/product-categories';
  static const buyerCart = '/buyer-cart';
  static const buyerOrders = '/buyer-orders';
  static const buyerOrderDetail = '/buyer-order-detail';
  static const buyerBulkEnquiry = '/buyer-bulk-enquiry';
  static const marketplace = '/marketplace';
  static const productDetail = '/product-detail';
  static const checkout = '/checkout';

  // FPO Admin
  static const fpoDashboard = '/fpo-dashboard';
  static const fpoMembers = '/fpo-members';
  static const fpoMemberDetail = '/fpo-member-detail';
  static const fpoApproval = '/fpo-approval';
  static const fpoBroadcast = '/fpo-broadcast';
  static const fpoStock = '/fpo-stock';
  static const fpoReports = '/fpo-reports';

  // Field Officer
  static const fieldOfficerHome = '/field-officer-home';
  static const alertFeed = '/alert-feed';
  static const districtMap = '/district-map';
  static const incidentDetail = '/incident-detail';
  static const fieldVisit = '/field-visit';
  static const schemeBeneficiaries = '/scheme-beneficiaries';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: false,
  routes: [
    // ── Onboarding ──────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.language,
      builder: (context, state) => const LanguageScreen(),
    ),
    GoRoute(
      path: AppRoutes.phoneLogin,
      builder: (context, state) => const PhoneLoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.otp,
      builder: (context, state) {
        final phone = state.extra as String? ?? '';
        return OtpScreen(phone: phone);
      },
    ),
    GoRoute(
      path: AppRoutes.profileSetup,
      builder: (context, state) => const ProfileSetupScreen(),
    ),

    // ── Beekeeper ───────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.apiary,
      builder: (context, state) => const ApiaryScreen(),
    ),
    GoRoute(
      path: AppRoutes.hiveDetail,
      builder: (context, state) {
        final hiveId = state.extra as String? ?? 'H-01';
        return HiveDetailScreen(hiveId: hiveId);
      },
    ),
    GoRoute(
      path: AppRoutes.hiveProducts,
      builder: (context, state) => const HiveProductsScreen(),
    ),
    GoRoute(
      path: AppRoutes.bestPractices,
      builder: (context, state) => const BestPracticesScreen(),
    ),
    GoRoute(
      path: AppRoutes.calendar,
      builder: (context, state) => const CalendarScreen(),
    ),
    GoRoute(
      path: AppRoutes.migration,
      builder: (context, state) => const MigrationScreen(),
    ),
    GoRoute(
      path: AppRoutes.productsSale,
      builder: (context, state) => const ProductsSaleScreen(),
    ),
    GoRoute(
      path: AppRoutes.alert,
      builder: (context, state) => const AlertScreen(),
    ),
    GoRoute(
      path: AppRoutes.flora,
      builder: (context, state) => const FloraScreen(),
    ),
    GoRoute(
      path: AppRoutes.camera,
      builder: (context, state) => const CameraScreen(),
    ),
    GoRoute(
      path: AppRoutes.location,
      builder: (context, state) => const LocationScreen(),
    ),
    GoRoute(
      path: AppRoutes.beeHealth,
      builder: (context, state) => const BeeHealthScreen(),
    ),
    GoRoute(
      path: AppRoutes.chatSupport,
      builder: (context, state) => const ChatSupportScreen(),
    ),
    GoRoute(
      path: AppRoutes.beekeeperProfile,
      builder: (context, state) => const BeekeeperProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.more,
      builder: (context, state) => const MoreScreen(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.inspectionWizard,
      builder: (context, state) {
        final hiveId = state.extra as String? ?? '';
        return InspectionWizardScreen(hiveId: hiveId);
      },
    ),
    GoRoute(
      path: AppRoutes.finance,
      builder: (context, state) => const FinanceScreen(),
    ),

    // ── Honey Collector ─────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.harvestLog,
      builder: (context, state) => const HarvestLogScreen(),
    ),
    GoRoute(
      path: AppRoutes.geotagCamera,
      builder: (context, state) => const GeotagCameraScreen(),
    ),
    GoRoute(
      path: AppRoutes.harvestDetail,
      builder: (context, state) => const HarvestDetailScreen(),
    ),
    GoRoute(
      path: AppRoutes.fpoSubmit,
      builder: (context, state) => const FpoSubmitScreen(),
    ),
    GoRoute(
      path: AppRoutes.digitalId,
      builder: (context, state) => const DigitalIdScreen(),
    ),

    // ── Buyer ────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.buyerHome,
      builder: (context, state) => const BuyerHomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.productCategories,
      builder: (context, state) => const ProductCategoriesScreen(),
    ),
    GoRoute(
      path: AppRoutes.buyerCart,
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: AppRoutes.buyerOrders,
      builder: (context, state) => const OrdersScreen(),
    ),
    GoRoute(
      path: AppRoutes.buyerOrderDetail,
      builder: (context, state) {
        final orderId = state.extra as String? ?? 'ORD-001';
        return OrderDetailScreen(orderId: orderId);
      },
    ),
    GoRoute(
      path: AppRoutes.buyerBulkEnquiry,
      builder: (context, state) => const BulkEnquiryScreen(),
    ),
    GoRoute(
      path: AppRoutes.marketplace,
      builder: (context, state) => const MarketplaceScreen(),
    ),
    GoRoute(
      path: AppRoutes.productDetail,
      builder: (context, state) => const ProductDetailScreen(),
    ),
    GoRoute(
      path: AppRoutes.checkout,
      builder: (context, state) => const CheckoutScreen(),
    ),

    // ── FPO Admin ────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.fpoDashboard,
      builder: (context, state) => const FpoDashboardScreen(),
    ),
    GoRoute(
      path: AppRoutes.fpoMembers,
      builder: (context, state) => const FpoMembersScreen(),
    ),
    GoRoute(
      path: AppRoutes.fpoMemberDetail,
      builder: (context, state) {
        final memberId = state.extra as String? ?? 'M-001';
        return FpoMemberDetailScreen(memberId: memberId);
      },
    ),
    GoRoute(
      path: AppRoutes.fpoApproval,
      builder: (context, state) => const FpoApprovalScreen(),
    ),
    GoRoute(
      path: AppRoutes.fpoBroadcast,
      builder: (context, state) => const FpoBroadcastScreen(),
    ),
    GoRoute(
      path: AppRoutes.fpoStock,
      builder: (context, state) => const FpoStockScreen(),
    ),
    GoRoute(
      path: AppRoutes.fpoReports,
      builder: (context, state) => const FpoReportsScreen(),
    ),

    // ── Field Officer ────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.fieldOfficerHome,
      builder: (context, state) => const FieldOfficerHomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.alertFeed,
      builder: (context, state) => const FieldOfficerAlertsScreen(),
    ),
    GoRoute(
      path: AppRoutes.districtMap,
      builder: (context, state) => const FieldOfficerMapScreen(),
    ),
    GoRoute(
      path: AppRoutes.incidentDetail,
      builder: (context, state) {
        final id = state.extra as String? ?? 'INC-001';
        return IncidentDetailScreen(incidentId: id);
      },
    ),
    GoRoute(
      path: AppRoutes.fieldVisit,
      builder: (context, state) => const FieldVisitScreen(),
    ),
    GoRoute(
      path: AppRoutes.schemeBeneficiaries,
      builder: (context, state) => const SchemeScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Route not found: ${state.error}'),
    ),
  ),
);
