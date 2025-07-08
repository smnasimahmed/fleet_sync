import 'package:fleet_sync/about_us_screen/about_us_page.dart';
import 'package:fleet_sync/card_details_screen/card_details_page.dart';
import 'package:fleet_sync/company_details_screen/company_details_page.dart';
import 'package:fleet_sync/custom_widgets/logo.dart';
import 'package:fleet_sync/edit_profile_screen/edit_profile_page.dart';
import 'package:fleet_sync/faq_screen/faq_page.dart';
import 'package:fleet_sync/forgot_password/forgot_password_page.dart';
import 'package:fleet_sync/home_screen/home_page.dart';
import 'package:fleet_sync/inbox_screen/component/chat_page.dart';
import 'package:fleet_sync/language_screen/language_page.dart';
import 'package:fleet_sync/log_out_popUp/log_out_popUp_page.dart';
import 'package:fleet_sync/login_screen/login_page.dart';
import 'package:fleet_sync/navbar/navbar.dart';
import 'package:fleet_sync/notifications_screen/notifications_page.dart';
import 'package:fleet_sync/otp_screen/otp_page.dart';
import 'package:fleet_sync/package_buying_screen/package_buying_page.dart';
import 'package:fleet_sync/payment_page/payment_page.dart';
import 'package:fleet_sync/personal_info_registration_screen/personal_info_registration_page.dart';
import 'package:fleet_sync/privarcy_policy_screen/privarcy_policy_page.dart';
import 'package:fleet_sync/report_problem_screen/report_problem_page.dart';
import 'package:fleet_sync/role_selection_screen/role_selection_page.dart';
import 'package:fleet_sync/routes/app_routes.dart';
import 'package:fleet_sync/routes/bindings/navigation_screen_binding.dart';
import 'package:fleet_sync/saved_item_screen/saved_item_page.dart';
import 'package:fleet_sync/set_password/set_password_page.dart';
import 'package:fleet_sync/sign_up_screen/sign_up_screen.dart';
import 'package:fleet_sync/subscription_screen/subscription_page.dart';
import 'package:fleet_sync/terms_condition_screen/terms_condition_page.dart';
import 'package:fleet_sync/truck_details_screen/truck_details_page.dart';
import 'package:fleet_sync/truck_sales_screen/truck_sales_page.dart';
import 'package:fleet_sync/truck_sell_post_form_screen/truck_sell_post_form_page.dart';
import 'package:fleet_sync/turck_information_screen/truck_information_page.dart';
import 'package:fleet_sync/update_password_screen/update_password_page.dart';
import 'package:fleet_sync/welcome_screen/welcome_page.dart';
import 'package:get/get.dart';

List<GetPage> appRouteFile = <GetPage>[
  GetPage(
    name: AppRoutes.login,
    page: () => LoginPage(),
    transition: Transition.noTransition,
    // TODO: Add Binding
    // TODO: Add middleware
  ),
  GetPage(
    name: AppRoutes.signUp,
    page: () => SignUpScreen(),
    transition: Transition.noTransition,
  ),

  GetPage(
    name: AppRoutes.otp,
    page: () => OtpPage(),
    transition: Transition.leftToRight,
  ),
  GetPage(
    name: AppRoutes.setResetPassword,
    page: () => SetPasswordPage(),
    transition: Transition.leftToRight,
  ),
  GetPage(
    name: AppRoutes.forgotPassword,
    page: () => ForgotPasswordPage(),
    transition: Transition.noTransition,
  ),
  GetPage(
    name: AppRoutes.roleSelection,
    page: () => RoleSelectionPage(),
    binding: NavigationScreenBinding(),
  ),
  GetPage(
    name: AppRoutes.personalInfoReg,
    page: () => PersonalInfoRegistrationPage(),
    binding: NavigationScreenBinding(),
  ),
  GetPage(name: AppRoutes.truckInformation, page: () => TruckInformationPage()),
  GetPage(name: AppRoutes.packageBuying, page: () => PackageBuyingPage()),
  GetPage(name: AppRoutes.paymentPage, page: () => PaymentPage()),
  GetPage(
    name: AppRoutes.welcomePage,
    page: () => WelcomePage(),
    binding: NavigationScreenBinding(),
  ),
  GetPage(name: AppRoutes.homePage, page: () => HomePage()),
  // GetPage(name: AppRoutes.popularCompanyCard, page: () => PopularCompanyCard()),
  GetPage(name: AppRoutes.logo, page: () => Logo()),
  // GetPage(name: AppRoutes.drawerPage, page: () => DrawerPage()),
  GetPage(
    name: AppRoutes.editProfilePage,
    page: () => EditProfilePage(),
    binding: NavigationScreenBinding(),
  ),
  GetPage(name: AppRoutes.savedPosts, page: () => SavedItemPage()),
  GetPage(name: AppRoutes.notificationsPage, page: () => NotificationsPage()),
  GetPage(name: AppRoutes.subscriptions, page: () => SubscriptionPage()),
  GetPage(name: AppRoutes.updatePasswordPage, page: () => UpdatePasswordPage()),
  GetPage(name: AppRoutes.aboutUsPage, page: () => AboutUsPage()),
  GetPage(name: AppRoutes.faq, page: () => FaqPage()),
  GetPage(name: AppRoutes.reportProblem, page: () => ReportProblemPage()),
  GetPage(name: AppRoutes.language, page: () => LanguagePage()),
  GetPage(name: AppRoutes.logOut, page: () => LogOutPopupPage()),
  GetPage(name: AppRoutes.updatePasswordPage, page: () => UpdatePasswordPage()),
  GetPage(name: AppRoutes.privacyPolicy, page: () => PrivarcyPolicyPage()),
  GetPage(name: AppRoutes.termsAndConditions, page: () => TermsConditionPage()),
  GetPage(name: AppRoutes.navbar, page: () => Navbar()),
  GetPage(name: AppRoutes.companyDetailsPage, page: () => CompanyDetailsPage()),
  // GetPage(name: AppRoutes.mapPage, page: () => MapPage()),
  GetPage(name: AppRoutes.truckSalesPage, page: () => TruckSalesPage()),
  GetPage(
    name: AppRoutes.truckDetailsPage,
    page: () => TruckDetailsPage(),
    binding: NavigationScreenBinding(),
  ),
  GetPage(name: AppRoutes.cardkDetailsPage, page: () => CardDetailsPage()),
  GetPage(
    name: AppRoutes.truckSellPostFormPage,
    page: () => TruckSellPostFormPage(),
  ),
   GetPage(
    name: AppRoutes.chatPage,
    page: () => ChatPage(),
  ),
];
