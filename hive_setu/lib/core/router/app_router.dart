import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/view/splash_screen.dart';
import '../../features/language/view/language_screen.dart';
import '../../features/auth/view/phone_login_screen.dart';
import '../../features/auth/view/otp_screen.dart';
import '../../features/profile/view/profile_setup_screen.dart';
import '../../features/home/view/home_screen.dart';
import '../../features/apiary/view/apiary_screen.dart';
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
import '../../features/wild_harvest/view/harvest_log_screen.dart';
import '../../features/wild_harvest/view/geotag_camera_screen.dart';
import '../../features/wild_harvest/view/harvest_detail_screen.dart';
import '../../features/wild_harvest/view/fpo_submit_screen.dart';
import '../../features/wild_harvest/view/digital_id_screen.dart';
import '../../features/marketplace/view/marketplace_screen.dart';
import '../../features/marketplace/view/product_detail_screen.dart';
import '../../features/marketplace/view/checkout_screen.dart';
import '../../features/fpo_admin/view/fpo_dashboard_screen.dart';
import '../../features/fpo_admin/view/fpo_members_screen.dart';
import '../../features/fpo_admin/view/fpo_approval_screen.dart';
import '../../features/fpo_admin/view/fpo_broadcast_screen.dart';
import '../../features/field_officer/view/field_officer_alerts_screen.dart';
import '../../features/field_officer/view/field_officer_map_screen.dart';
import '../../features/buyer/view/buyer_dashboard_screen.dart';
import '../../features/buyer/view/product_categories_screen.dart';
import '../../features/buyer/view/cart_screen.dart';
import '../../features/buyer/view/shipping_details_screen.dart';
import '../../features/buyer/view/payment_screen.dart';
import '../../features/buyer/view/order_confirmation_screen.dart';
import '../../features/buyer/view/orders_list_screen.dart';
import '../../features/buyer/view/bulk_enquiry_screen.dart';
import '../../features/buyer/view/supplier_profile_screen.dart';
import '../../features/fpo_admin/view/member_detail_screen.dart';
import '../../features/fpo_admin/view/stock_listings_screen.dart';
import '../../features/fpo_admin/view/reports_center_screen.dart';
import '../../features/field_officer/view/officer_dashboard_screen.dart';
import '../../features/field_officer/view/scheme_beneficiary_list_screen.dart';
import '../../features/field_officer/view/beneficiary_detail_screen.dart';
import '../../features/field_officer/view/incident_map_screen.dart';
import '../../features/field_officer/view/incident_detail_screen.dart';
import '../../features/field_officer/view/field_visit_planner_screen.dart';
import '../../features/field_officer/view/field_visit_log_screen.dart';
import '../../features/field_officer/view/officer_reports_screen.dart';

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

  // Honey Collector
  static const harvestLog = '/harvest-log';
  static const geotagCamera = '/geotag-camera';
  static const harvestDetail = '/harvest-detail';
  static const fpoSubmit = '/fpo-submit';
  static const digitalId = '/digital-id';

  // Buyer
  static const marketplace = '/marketplace';
  static const productDetail = '/product-detail';
  static const checkout = '/checkout';
  static const buyerDashboard = '/buyer-dashboard';
  static const productCategories = '/product-categories';
  static const cart = '/cart';
  static const shippingDetails = '/shipping-details';
  static const payment = '/payment';
  static const orderConfirmation = '/order-confirmation';
  static const ordersList = '/orders-list';
  static const bulkEnquiry = '/bulk-enquiry';
  static const supplierProfile = '/supplier-profile';

  // FPO Admin
  static const fpoDashboard = '/fpo-dashboard';
  static const fpoMembers = '/fpo-members';
  static const fpoApproval = '/fpo-approval';
  static const fpoBroadcast = '/fpo-broadcast';
  static const memberDetail = '/member-detail';
  static const stockListings = '/stock-listings';
  static const reportsCenter = '/reports-center';

  // Field Officer
  static const alertFeed = '/alert-feed';
  static const districtMap = '/district-map';
  static const officerDashboard = '/officer-dashboard';
  static const schemeBeneficiaryList = '/scheme-beneficiaries';
  static const beneficiaryDetail = '/beneficiary-detail';
  static const incidentMap = '/incident-map';
  static const incidentDetail = '/incident-detail';
  static const fieldVisitPlanner = '/field-visit-planner';
  static const fieldVisitLog = '/field-visit-log';
  static const officerReports = '/officer-reports';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: false,
  routes: [
    // Onboarding
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.language,
      name: 'language',
      builder: (context, state) => const LanguageScreen(),
    ),
    GoRoute(
      path: AppRoutes.phoneLogin,
      name: 'phoneLogin',
      builder: (context, state) => const PhoneLoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.otp,
      name: 'otp',
      builder: (context, state) {
        final phone = state.uri.queryParameters['phone'] ?? '';
        final role = state.uri.queryParameters['role'] ?? 'beekeeper';
        return OtpScreen(phone: phone, role: role);
      },
    ),
    GoRoute(
      path: AppRoutes.profileSetup,
      name: 'profileSetup',
      builder: (context, state) {
        final role = state.uri.queryParameters['role'] ?? 'beekeeper';
        return ProfileSetupScreen(role: role);
      },
    ),

    // Beekeeper Core
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.apiary,
      name: 'apiary',
      builder: (context, state) => const ApiaryScreen(),
    ),
    GoRoute(
      path: AppRoutes.hiveProducts,
      name: 'hiveProducts',
      builder: (context, state) => const HiveProductsScreen(),
    ),
    GoRoute(
      path: AppRoutes.bestPractices,
      name: 'bestPractices',
      builder: (context, state) => const BestPracticesScreen(),
    ),
    GoRoute(
      path: AppRoutes.calendar,
      name: 'calendar',
      builder: (context, state) => const CalendarScreen(),
    ),
    GoRoute(
      path: AppRoutes.migration,
      name: 'migration',
      builder: (context, state) => const MigrationScreen(),
    ),
    GoRoute(
      path: AppRoutes.productsSale,
      name: 'productsSale',
      builder: (context, state) => const ProductsSaleScreen(),
    ),
    GoRoute(
      path: AppRoutes.alert,
      name: 'alert',
      builder: (context, state) => const AlertScreen(),
    ),
    GoRoute(
      path: AppRoutes.flora,
      name: 'flora',
      builder: (context, state) => const FloraScreen(),
    ),
    GoRoute(
      path: AppRoutes.camera,
      name: 'camera',
      builder: (context, state) => const CameraScreen(),
    ),
    GoRoute(
      path: AppRoutes.location,
      name: 'location',
      builder: (context, state) => const LocationScreen(),
    ),
    GoRoute(
      path: AppRoutes.beeHealth,
      name: 'beeHealth',
      builder: (context, state) => const BeeHealthScreen(),
    ),
    GoRoute(
      path: AppRoutes.chatSupport,
      name: 'chatSupport',
      builder: (context, state) => const ChatSupportScreen(),
    ),
    GoRoute(
      path: AppRoutes.beekeeperProfile,
      name: 'beekeeperProfile',
      builder: (context, state) => const BeekeeperProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.more,
      name: 'more',
      builder: (context, state) => const MoreScreen(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),

    // Honey Collector
    GoRoute(
      path: AppRoutes.harvestLog,
      name: 'harvestLog',
      builder: (context, state) => const HarvestLogScreen(),
    ),
    GoRoute(
      path: AppRoutes.geotagCamera,
      name: 'geotagCamera',
      builder: (context, state) => const GeotagCameraScreen(),
    ),
    GoRoute(
      path: AppRoutes.harvestDetail,
      name: 'harvestDetail',
      builder: (context, state) => const HarvestDetailScreen(),
    ),
    GoRoute(
      path: AppRoutes.fpoSubmit,
      name: 'fpoSubmit',
      builder: (context, state) => const FpoSubmitScreen(),
    ),
    GoRoute(
      path: AppRoutes.digitalId,
      name: 'digitalId',
      builder: (context, state) => const DigitalIdScreen(),
    ),

    // Buyer
    GoRoute(
      path: AppRoutes.marketplace,
      name: 'marketplace',
      builder: (context, state) => const MarketplaceScreen(),
    ),
    GoRoute(
      path: AppRoutes.productDetail,
      name: 'productDetail',
      builder: (context, state) => const ProductDetailScreen(),
    ),
    GoRoute(
      path: AppRoutes.checkout,
      name: 'checkout',
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      path: AppRoutes.buyerDashboard,
      name: 'buyerDashboard',
      builder: (context, state) => const BuyerDashboardScreen(),
    ),
    GoRoute(
      path: AppRoutes.productCategories,
      name: 'productCategories',
      builder: (context, state) => const ProductCategoriesScreen(),
    ),
    GoRoute(
      path: AppRoutes.cart,
      name: 'cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: AppRoutes.shippingDetails,
      name: 'shippingDetails',
      builder: (context, state) => const ShippingDetailsScreen(),
    ),
    GoRoute(
      path: AppRoutes.payment,
      name: 'payment',
      builder: (context, state) => const PaymentScreen(),
    ),
    GoRoute(
      path: AppRoutes.orderConfirmation,
      name: 'orderConfirmation',
      builder: (context, state) => const OrderConfirmationScreen(),
    ),
    GoRoute(
      path: AppRoutes.ordersList,
      name: 'ordersList',
      builder: (context, state) => const OrdersListScreen(),
    ),
    GoRoute(
      path: AppRoutes.bulkEnquiry,
      name: 'bulkEnquiry',
      builder: (context, state) => const BulkEnquiryScreen(),
    ),
    GoRoute(
      path: AppRoutes.supplierProfile,
      name: 'supplierProfile',
      builder: (context, state) => const SupplierProfileScreen(),
    ),

    // FPO Admin
    GoRoute(
      path: AppRoutes.fpoDashboard,
      name: 'fpoDashboard',
      builder: (context, state) => const FpoDashboardScreen(),
    ),
    GoRoute(
      path: AppRoutes.fpoMembers,
      name: 'fpoMembers',
      builder: (context, state) => const FpoMembersScreen(),
    ),
    GoRoute(
      path: AppRoutes.fpoApproval,
      name: 'fpoApproval',
      builder: (context, state) => const FpoApprovalScreen(),
    ),
    GoRoute(
      path: AppRoutes.fpoBroadcast,
      name: 'fpoBroadcast',
      builder: (context, state) => const FpoBroadcastScreen(),
    ),
    GoRoute(
      path: AppRoutes.memberDetail,
      name: 'memberDetail',
      builder: (context, state) => const MemberDetailScreen(),
    ),
    GoRoute(
      path: AppRoutes.stockListings,
      name: 'stockListings',
      builder: (context, state) => const StockListingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.reportsCenter,
      name: 'reportsCenter',
      builder: (context, state) => const ReportsCenterScreen(),
    ),

    // Field Officer
    GoRoute(
      path: AppRoutes.alertFeed,
      name: 'alertFeed',
      builder: (context, state) => const FieldOfficerAlertsScreen(),
    ),
    GoRoute(
      path: AppRoutes.districtMap,
      name: 'districtMap',
      builder: (context, state) => const FieldOfficerMapScreen(),
    ),
    GoRoute(
      path: AppRoutes.officerDashboard,
      name: 'officerDashboard',
      builder: (context, state) => const OfficerDashboardScreen(),
    ),
    GoRoute(
      path: AppRoutes.schemeBeneficiaryList,
      name: 'schemeBeneficiaryList',
      builder: (context, state) => const SchemeBeneficiaryListScreen(),
    ),
    GoRoute(
      path: AppRoutes.beneficiaryDetail,
      name: 'beneficiaryDetail',
      builder: (context, state) => const BeneficiaryDetailScreen(),
    ),
    GoRoute(
      path: AppRoutes.incidentMap,
      name: 'incidentMap',
      builder: (context, state) => const IncidentMapScreen(),
    ),
    GoRoute(
      path: AppRoutes.incidentDetail,
      name: 'incidentDetail',
      builder: (context, state) => const IncidentDetailScreen(),
    ),
    GoRoute(
      path: AppRoutes.fieldVisitPlanner,
      name: 'fieldVisitPlanner',
      builder: (context, state) => const FieldVisitPlannerScreen(),
    ),
    GoRoute(
      path: AppRoutes.fieldVisitLog,
      name: 'fieldVisitLog',
      builder: (context, state) => const FieldVisitLogScreen(),
    ),
    GoRoute(
      path: AppRoutes.officerReports,
      name: 'officerReports',
      builder: (context, state) => const OfficerReportsScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Route not found: ${state.error}'),
    ),
  ),
);
