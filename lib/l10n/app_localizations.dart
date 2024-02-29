import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @vietnamese_text.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get vietnamese_text;

  /// No description provided for @english_text.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english_text;

  /// No description provided for @onboarding_item_1_text.
  ///
  /// In en, this message translates to:
  /// **'One best app for all your needs'**
  String get onboarding_item_1_text;

  /// No description provided for @onboarding_item_2_text.
  ///
  /// In en, this message translates to:
  /// **'Get real-time updates for all deliveries'**
  String get onboarding_item_2_text;

  /// No description provided for @onboarding_item_3_text.
  ///
  /// In en, this message translates to:
  /// **'Follow and get update from favorite store'**
  String get onboarding_item_3_text;

  /// No description provided for @get_started.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get get_started;

  /// No description provided for @title_get_started_text.
  ///
  /// In en, this message translates to:
  /// **'By taping “Get Started” and using the Shopline app, you’re agreeing to our'**
  String get title_get_started_text;

  /// No description provided for @terms_of_service_text.
  ///
  /// In en, this message translates to:
  /// **'terms of service'**
  String get terms_of_service_text;

  /// No description provided for @and_text.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and_text;

  /// No description provided for @privacy_policy_text.
  ///
  /// In en, this message translates to:
  /// **'privacy policy'**
  String get privacy_policy_text;

  /// No description provided for @content_text.
  ///
  /// In en, this message translates to:
  /// **'Easy shopping for all your needs just in hand, trusted by millions of people in the world'**
  String get content_text;

  /// No description provided for @search_language_text.
  ///
  /// In en, this message translates to:
  /// **'Search language'**
  String get search_language_text;

  /// No description provided for @language_text.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language_text;

  /// No description provided for @setting_text.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting_text;

  /// No description provided for @general_text.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general_text;

  /// No description provided for @account_setting_text.
  ///
  /// In en, this message translates to:
  /// **'Account Setting'**
  String get account_setting_text;

  /// No description provided for @security_text.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security_text;

  /// No description provided for @dark_theme_text.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get dark_theme_text;

  /// No description provided for @others_text.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get others_text;

  /// No description provided for @get_help_text.
  ///
  /// In en, this message translates to:
  /// **'Get Help'**
  String get get_help_text;

  /// No description provided for @community_text.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community_text;

  /// No description provided for @log_out_successfully_text.
  ///
  /// In en, this message translates to:
  /// **'Log out successfully'**
  String get log_out_successfully_text;

  /// No description provided for @log_out_text.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get log_out_text;

  /// No description provided for @change_password_text.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password_text;

  /// No description provided for @welcome_back_text.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcome_back_text;

  /// No description provided for @please_enter_your_details_text.
  ///
  /// In en, this message translates to:
  /// **'Please enter your details'**
  String get please_enter_your_details_text;

  /// No description provided for @email_cant_be_blank_text.
  ///
  /// In en, this message translates to:
  /// **'Email can\'t be blank'**
  String get email_cant_be_blank_text;

  /// No description provided for @password_text.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password_text;

  /// No description provided for @password_cannot_be_left_blank_text.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be left blank'**
  String get password_cannot_be_left_blank_text;

  /// No description provided for @password_8_characters_long_text.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long'**
  String get password_8_characters_long_text;

  /// No description provided for @forgot_password_text.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgot_password_text;

  /// No description provided for @sign_in_text.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in_text;

  /// No description provided for @or_sign_in_with_text.
  ///
  /// In en, this message translates to:
  /// **'Or sign in with'**
  String get or_sign_in_with_text;

  /// No description provided for @dont_have_an_account_text.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account'**
  String get dont_have_an_account_text;

  /// No description provided for @sign_up_text.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up_text;

  /// No description provided for @successful_login_text.
  ///
  /// In en, this message translates to:
  /// **'Successful login'**
  String get successful_login_text;

  /// No description provided for @login_failure_text.
  ///
  /// In en, this message translates to:
  /// **'Login failure'**
  String get login_failure_text;

  /// No description provided for @user_does_not_exist_text.
  ///
  /// In en, this message translates to:
  /// **'User does not exist'**
  String get user_does_not_exist_text;

  /// No description provided for @wrong_password_text.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password'**
  String get wrong_password_text;

  /// No description provided for @noti_verification_email_text.
  ///
  /// In en, this message translates to:
  /// **'An authentication code has been sent to your email. Please authenticate to continue'**
  String get noti_verification_email_text;

  /// No description provided for @registration_failure_text.
  ///
  /// In en, this message translates to:
  /// **'Registration failure'**
  String get registration_failure_text;

  /// No description provided for @welcome_text.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome_text;

  /// No description provided for @lets_get_started_with_free_shopline_account_text.
  ///
  /// In en, this message translates to:
  /// **'Let’s get started with a free Shopline account'**
  String get lets_get_started_with_free_shopline_account_text;

  /// No description provided for @fullname_text.
  ///
  /// In en, this message translates to:
  /// **'Fullname'**
  String get fullname_text;

  /// No description provided for @fullname_cannot_be_left_blank_text.
  ///
  /// In en, this message translates to:
  /// **'First and last names cannot be left blank'**
  String get fullname_cannot_be_left_blank_text;

  /// No description provided for @do_already_have_an_account_text.
  ///
  /// In en, this message translates to:
  /// **'Do Already have an account'**
  String get do_already_have_an_account_text;

  /// No description provided for @shopline_text.
  ///
  /// In en, this message translates to:
  /// **'Shopline'**
  String get shopline_text;

  /// No description provided for @one_best_app_for_all_your_needs_text.
  ///
  /// In en, this message translates to:
  /// **'One best app for all your needs'**
  String get one_best_app_for_all_your_needs_text;

  /// No description provided for @already_have_an_account_text.
  ///
  /// In en, this message translates to:
  /// **'Already have an account'**
  String get already_have_an_account_text;

  /// No description provided for @continue_with_email.
  ///
  /// In en, this message translates to:
  /// **'Continue with Email'**
  String get continue_with_email;

  /// No description provided for @continue_with_google.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continue_with_google;

  /// No description provided for @continue_with_apple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continue_with_apple;

  /// No description provided for @chat_text.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat_text;

  /// No description provided for @social_text.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get social_text;

  /// No description provided for @account_text.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account_text;

  /// No description provided for @search_text.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search_text;

  /// No description provided for @please_share_about_your_day_today_text.
  ///
  /// In en, this message translates to:
  /// **'Please share about your day today'**
  String get please_share_about_your_day_today_text;

  /// No description provided for @google_account_sign_in_method_text.
  ///
  /// In en, this message translates to:
  /// **'The account is signed in with google. Please try again'**
  String get google_account_sign_in_method_text;

  /// No description provided for @account_exists_with_different_credential_text.
  ///
  /// In en, this message translates to:
  /// **'This account is already registered'**
  String get account_exists_with_different_credential_text;

  /// No description provided for @email_already_exists_text.
  ///
  /// In en, this message translates to:
  /// **'Email already exists'**
  String get email_already_exists_text;

  /// No description provided for @invalid_email_text.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalid_email_text;

  /// No description provided for @operation_is_not_allowed_text.
  ///
  /// In en, this message translates to:
  /// **'Account registration is not allowed at this time'**
  String get operation_is_not_allowed_text;

  /// No description provided for @weak_password_text.
  ///
  /// In en, this message translates to:
  /// **'The password is too weak'**
  String get weak_password_text;

  /// No description provided for @too_many_request_text.
  ///
  /// In en, this message translates to:
  /// **'Too many login requests in a short period of time. Please try again later'**
  String get too_many_request_text;

  /// No description provided for @invalid_credential_text.
  ///
  /// In en, this message translates to:
  /// **'Invalid or expired credentials'**
  String get invalid_credential_text;

  /// No description provided for @user_disabled_text.
  ///
  /// In en, this message translates to:
  /// **'Your account has been disabled'**
  String get user_disabled_text;

  /// No description provided for @user_not_found_text.
  ///
  /// In en, this message translates to:
  /// **'Account doesn\'t exist'**
  String get user_not_found_text;

  /// No description provided for @invalid_verification_code_text.
  ///
  /// In en, this message translates to:
  /// **'The verification code is invalid or expired'**
  String get invalid_verification_code_text;

  /// No description provided for @google_sign_in_text.
  ///
  /// In en, this message translates to:
  /// **'There was an error signing in'**
  String get google_sign_in_text;

  /// No description provided for @provacy_policy_text.
  ///
  /// In en, this message translates to:
  /// **'Provacy & Policy'**
  String get provacy_policy_text;

  /// No description provided for @social_media_text.
  ///
  /// In en, this message translates to:
  /// **'Social Media'**
  String get social_media_text;

  /// No description provided for @connect_email_account_text.
  ///
  /// In en, this message translates to:
  /// **'Connect email account'**
  String get connect_email_account_text;

  /// No description provided for @connect_google_account_text.
  ///
  /// In en, this message translates to:
  /// **'Connect google account'**
  String get connect_google_account_text;

  /// No description provided for @connect_apple_account_text.
  ///
  /// In en, this message translates to:
  /// **'Connect apple account'**
  String get connect_apple_account_text;

  /// No description provided for @connected_text.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected_text;

  /// No description provided for @connect_text.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connect_text;

  /// No description provided for @notification_text.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification_text;

  /// No description provided for @you_want_to_exit_the_application_text.
  ///
  /// In en, this message translates to:
  /// **'You want to exit the application'**
  String get you_want_to_exit_the_application_text;

  /// No description provided for @yes_text.
  ///
  /// In en, this message translates to:
  /// **'Escape'**
  String get yes_text;

  /// No description provided for @no_text.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no_text;

  /// No description provided for @view_more_text.
  ///
  /// In en, this message translates to:
  /// **'View More'**
  String get view_more_text;

  /// No description provided for @show_less_text.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get show_less_text;

  /// No description provided for @your_password_text.
  ///
  /// In en, this message translates to:
  /// **'Your password must different from previous password'**
  String get your_password_text;

  /// No description provided for @des_password_text.
  ///
  /// In en, this message translates to:
  /// **'Your password needs to be at least 6 characters long. Includes some words and phrases to make it even safer'**
  String get des_password_text;

  /// No description provided for @continue_text.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_text;

  /// No description provided for @password_updated_text.
  ///
  /// In en, this message translates to:
  /// **'Password Updated'**
  String get password_updated_text;

  /// No description provided for @your_password_successfully_text.
  ///
  /// In en, this message translates to:
  /// **'Your password has been set up successfully'**
  String get your_password_successfully_text;

  /// No description provided for @redirecting_sign_in_text.
  ///
  /// In en, this message translates to:
  /// **'Redirecting sign in page in'**
  String get redirecting_sign_in_text;

  /// No description provided for @sec_text.
  ///
  /// In en, this message translates to:
  /// **'sec'**
  String get sec_text;

  /// No description provided for @back_to_sign_in_text.
  ///
  /// In en, this message translates to:
  /// **'Back to Sign In'**
  String get back_to_sign_in_text;

  /// No description provided for @successful_registration_text.
  ///
  /// In en, this message translates to:
  /// **'Successful registration'**
  String get successful_registration_text;

  /// No description provided for @contact_text.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact_text;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
