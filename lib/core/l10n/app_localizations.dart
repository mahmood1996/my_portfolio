import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Mahmood Abdelrazek Ali | Portfolio'**
  String get appTitle;

  /// No description provided for @authorName.
  ///
  /// In en, this message translates to:
  /// **'Mahmood Abdelrazek Ali'**
  String get authorName;

  /// No description provided for @navAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get navAbout;

  /// No description provided for @navExperience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get navExperience;

  /// No description provided for @navProjects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get navProjects;

  /// No description provided for @navSkills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get navSkills;

  /// No description provided for @navReadings.
  ///
  /// In en, this message translates to:
  /// **'Readings'**
  String get navReadings;

  /// No description provided for @navContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get navContact;

  /// No description provided for @downloadCv.
  ///
  /// In en, this message translates to:
  /// **'Download CV'**
  String get downloadCv;

  /// No description provided for @heroTagline.
  ///
  /// In en, this message translates to:
  /// **'SENIOR FLUTTER DEVELOPER'**
  String get heroTagline;

  /// No description provided for @heroHeadlinePart1.
  ///
  /// In en, this message translates to:
  /// **'Building High-Performance '**
  String get heroHeadlinePart1;

  /// No description provided for @heroHeadlinePart2.
  ///
  /// In en, this message translates to:
  /// **'Mobile Experiences'**
  String get heroHeadlinePart2;

  /// No description provided for @heroBio.
  ///
  /// In en, this message translates to:
  /// **'Senior Flutter Developer with 6+ years of experience building and shipping production mobile applications across Android, iOS, Web, and Windows. Strong background in Test-Driven Development (TDD), Clean Architecture, and modular design, with over 20 published applications.'**
  String get heroBio;

  /// No description provided for @heroExploreWork.
  ///
  /// In en, this message translates to:
  /// **'Explore My Work'**
  String get heroExploreWork;

  /// No description provided for @heroPartnerWithMe.
  ///
  /// In en, this message translates to:
  /// **'Get In Touch'**
  String get heroPartnerWithMe;

  /// No description provided for @experienceSectionTag.
  ///
  /// In en, this message translates to:
  /// **'MY JOURNEY'**
  String get experienceSectionTag;

  /// No description provided for @experienceSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Professional Impact & Evolution'**
  String get experienceSectionTitle;

  /// No description provided for @projectsSectionTag.
  ///
  /// In en, this message translates to:
  /// **'PORTFOLIO'**
  String get projectsSectionTag;

  /// No description provided for @projectsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Featured Solutions'**
  String get projectsSectionTitle;

  /// No description provided for @projectsSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A selection of high-impact applications where architectural precision meets exceptional user experience.'**
  String get projectsSectionSubtitle;

  /// No description provided for @appStore.
  ///
  /// In en, this message translates to:
  /// **'App Store'**
  String get appStore;

  /// No description provided for @playStore.
  ///
  /// In en, this message translates to:
  /// **'Play Store'**
  String get playStore;

  /// No description provided for @skillsSectionTag.
  ///
  /// In en, this message translates to:
  /// **'METHODOLOGY'**
  String get skillsSectionTag;

  /// No description provided for @skillsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Expertise in Strategic Engineering'**
  String get skillsSectionTitle;

  /// No description provided for @skillsSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'My toolkit is curated for high-impact enterprise solutions, focusing on reliability, speed, and long-term maintainability.'**
  String get skillsSectionSubtitle;

  /// No description provided for @readingsSectionTag.
  ///
  /// In en, this message translates to:
  /// **'INTELLECTUAL GROWTH'**
  String get readingsSectionTag;

  /// No description provided for @readingsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Curated Professional Readings'**
  String get readingsSectionTitle;

  /// No description provided for @contactSectionTag.
  ///
  /// In en, this message translates to:
  /// **'GET IN TOUCH'**
  String get contactSectionTag;

  /// No description provided for @contactSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Connect & Collaborate'**
  String get contactSectionTitle;

  /// No description provided for @contactSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Currently open to senior Flutter development roles, technical consulting, and mobile engineering opportunities.'**
  String get contactSectionSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'EMAIL'**
  String get emailLabel;

  /// No description provided for @emailValue.
  ///
  /// In en, this message translates to:
  /// **'mahmood.abdelrazek@outlook.com'**
  String get emailValue;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'PHONE'**
  String get phoneLabel;

  /// No description provided for @phoneValue.
  ///
  /// In en, this message translates to:
  /// **'(+20) 106 150 1137'**
  String get phoneValue;

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'LOCATION'**
  String get locationLabel;

  /// No description provided for @locationValue.
  ///
  /// In en, this message translates to:
  /// **'Cairo, Egypt'**
  String get locationValue;

  /// No description provided for @formFullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'FULL NAME'**
  String get formFullNameLabel;

  /// No description provided for @formFullNameHint.
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get formFullNameHint;

  /// No description provided for @formCorporateEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'EMAIL ADDRESS'**
  String get formCorporateEmailLabel;

  /// No description provided for @formCorporateEmailHint.
  ///
  /// In en, this message translates to:
  /// **'john@company.com'**
  String get formCorporateEmailHint;

  /// No description provided for @formProjectSummaryLabel.
  ///
  /// In en, this message translates to:
  /// **'MESSAGE / PROJECT SUMMARY'**
  String get formProjectSummaryLabel;

  /// No description provided for @formProjectSummaryHint.
  ///
  /// In en, this message translates to:
  /// **'How can I help you build or scale your mobile application?'**
  String get formProjectSummaryHint;

  /// No description provided for @formFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get formFieldRequired;

  /// No description provided for @formEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter valid email'**
  String get formEmailInvalid;

  /// No description provided for @sendStrategicInquiry.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendStrategicInquiry;

  /// No description provided for @inquirySentDefault.
  ///
  /// In en, this message translates to:
  /// **'Message Sent!'**
  String get inquirySentDefault;

  /// No description provided for @footerRole.
  ///
  /// In en, this message translates to:
  /// **'SENIOR FLUTTER DEVELOPER'**
  String get footerRole;

  /// No description provided for @footerTagline.
  ///
  /// In en, this message translates to:
  /// **'Building high-performance cross-platform mobile applications with Clean Architecture and TDD.'**
  String get footerTagline;

  /// No description provided for @socialLinkedIn.
  ///
  /// In en, this message translates to:
  /// **'LinkedIn'**
  String get socialLinkedIn;

  /// No description provided for @socialGitHub.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get socialGitHub;

  /// No description provided for @socialGitLab.
  ///
  /// In en, this message translates to:
  /// **'GitLab'**
  String get socialGitLab;

  /// No description provided for @footerCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2026 Mahmood Abdelrazek Ali. All rights reserved.'**
  String get footerCopyright;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
