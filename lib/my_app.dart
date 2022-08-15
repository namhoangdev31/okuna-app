import 'dart:async';
import 'dart:io';

import 'package:Okuna/UiAndLogic/splash.dart';
import 'package:Okuna/pages/home/pages/menu/pages/privacy_policy.dart';
import 'package:Okuna/pages/waitlist/subscribe_done_step.dart';
import 'package:Okuna/pages/waitlist/subscribe_email_step.dart';
import 'package:Okuna/provider.dart';
import 'package:Okuna/services/localization.dart';
import 'package:Okuna/services/universal_links/universal_links.dart';
import 'package:Okuna/services/user.dart';
import 'package:Okuna/translation/constants.dart';
import 'package:Okuna/widgets/toast.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter\_localizations/flutter\_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'UiAndLogic/Initscreen.dart';
import 'UiAndLogic/chat_socket/chat_socket_bloc.dart';
import 'delegates/es_es_localizations_delegate.dart';
import 'delegates/localization_delegate.dart';
import 'delegates/pt_br_localizations_delegate.dart';
import 'delegates/sv_se_localizations_delegate.dart';

// import 'ui/chat/blocs/chat_socket/chat_socket_bloc.dart';

class MyApp extends StatefulWidget {
  final openbookProviderKey = GlobalKey<OpenbookProviderState>();

  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale? newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;

    state.setState(() {
      state.locale = newLocale;
    });
  }
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

FirebaseAnalyticsObserver observer =
    FirebaseAnalyticsObserver(analytics: _analytics);

class _MyAppState extends State<MyApp> {
  Locale? locale;
  late bool _needsBootstrap;

  // static const MAX_NETWORK_IMAGE_CACHE_MB = 200;
  // static const MAX_NETWORK_IMAGE_CACHE_ENTRIES = 1000;

  UserService? _userService;
  LocalizationService? _localizationService;

  @override
  void initState() {
    super.initState();
    _needsBootstrap = true;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
  }

  void bootstrap() {
    // DiskCache().maxEntries = MAX_NETWORK_IMAGE_CACHE_ENTRIES;
    //DiskCache().maxSizeBytes = MAX_NETWORK_IMAGE_CACHE_MB * 1000000; // 200mb
  }

  @override
  Widget build(BuildContext context) {
    if (_needsBootstrap) {
      bootstrap();
      _needsBootstrap = false;
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        ScreenUtil.init(
          context,
          orientation: orientation,
          designSize: Size(411, 820),
          // allowFontScaling: false,
        );
        return OpenbookProvider(
          key: widget.openbookProviderKey,
          child: BlocProvider<ChatSocketBloc>(
            create: (context) => ChatSocketBloc(),
            child: OBToast(
              child: MaterialApp(
                  navigatorObservers: [routeObserver, observer],
                  locale: this.locale,
                  debugShowCheckedModeBanner: false,
                  localeResolutionCallback: (deviceLocale, supportedLocales) {
                    // if no deviceLocale use english
                    if (deviceLocale == null) {
                      this.locale = Locale('vi', 'VN');
                      return this.locale;
                    }
                    // initialise locale from device
                    if (deviceLocale != null &&
                        supportedLanguages
                            .contains(deviceLocale.languageCode) &&
                        this.locale == null) {
                      Locale supportedMatchedLocale =
                          supportedLocales.firstWhere((Locale locale) =>
                              locale.languageCode == deviceLocale.languageCode);
                      this.locale = supportedMatchedLocale;
                    } else if (this.locale == null) {
                      print(
                          'Locale ${deviceLocale.languageCode} not supported, defaulting to en');
                      this.locale = Locale('vi', 'VN');
                    }
                    return this.locale;
                  },
                  title: 'Okuro',
                  supportedLocales: supportedLocales,
                  localizationsDelegates: [
                    const LocalizationServiceDelegate(),
                    GlobalCupertinoLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    const MaterialLocalizationPtBRDelegate(),
                    const CupertinoLocalizationPtBRDelegate(),
                    const MaterialLocalizationEsESDelegate(),
                    const CupertinoLocalizationEsESDelegate(),
                    const MaterialLocalizationSvSEDelegate(),
                    const CupertinoLocalizationSvSEDelegate(),
                  ],
                  theme: ThemeData(
                    buttonTheme: ButtonThemeData(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0))),
                    primarySwatch: Colors.blue,
                    textTheme: GoogleFonts.montserratTextTheme(),
                    appBarTheme: AppBarTheme(
                      titleTextStyle: GoogleFonts.montserrat(),
                    ),
                  ),
                  routes: {
                    '/': (BuildContext context) {
                      bootstrapOpenbookProviderInContext(context);
                      return SplashScreen(
                          // homeAnalytics: _analytics, homeObserver: observer
                          );
                    },
                    '/auth': (BuildContext context) {
                      bootstrapOpenbookProviderInContext(context);
                      return OBAuthSplashPage();
                    },
                    // '/auth/create_account': (BuildContext context) {
                    //   bootstrapOpenbookProviderInContext(context);
                    //   return OBAuthCreateAccountPage();
                    // },
                    // '/auth/verify_phone_number_step': (BuildContext context) {
                    //   bootstrapOpenbookProviderInContext(context);
                    //   return VerifyPhoneNumberPage();
                    // },
                    // '/auth/verify_phone_step': (BuildContext context) {
                    //   bootstrapOpenbookProviderInContext(context);
                    //   return VerifyPhonePage();
                    // },
                    // '/auth/set_password_step': (BuildContext context) {
                    //   bootstrapOpenbookProviderInContext(context);
                    //   return OBAuthSetPasswordPage();
                    // },
                    // '/auth/set_password': (BuildContext context) {
                    //   bootstrapOpenbookProviderInContext(context);
                    //   return OBAuthSetPassPage();
                    // },
                    // '/auth/get-started': (BuildContext context) {
                    //   bootstrapOpenbookProviderInContext(context);
                    //   return OBAuthGetStartedPage();
                    // },
                    // '/auth/legal_step': (BuildContext context) {
                    //   bootstrapOpenbookProviderInContext(context);
                    //   return OBLegalStepPage();
                    // },
                    // '/auth/accept_step': (BuildContext context) {
                    //   bootstrapOpenbookProviderInContext(context);
                    //   return OBAcceptStepPage();
                    // },
                    // '/auth/name_step': (BuildContext context) {
                    //   bootstrapOpenbookProviderInContext(context);
                    //   return OBAuthNameStepPage();
                    // },
                    // '/auth/email_step': (BuildContext context) {
                    //   bootstrapOpenbookProviderInContext(context);
                    //   return OBAuthEmailStepPage();
                    // },
                    // '/auth/username_step': (BuildContext context) {
                    //   bootstrapOpenbookProviderInContext(context);
                    //   return OBAuthUsernameStepPage();
                    // },
                    // '/auth/password_step': (BuildContext context) {
                    //   bootstrapOpenbookProviderInContext(context);
                    //   return OBAuthPasswordStepPage();
                    // },
                    // '/auth/submit_step': (BuildContext context) {
                    //   bootstrapOpenbookProviderInContext(context);
                    //   return OBAuthSubmitPage();
                    // },
                    // '/auth/done_step': (BuildContext context) {
                    //   bootstrapOpenbookProviderInContext(context);
                    //   return OBAuthDonePage();
                    // },
                    // '/auth/suggested_communities': (BuildContext context) {
                    //   bootstrapOpenbookProviderInContext(context);
                    //   return OBSuggestedCommunitiesPage();
                    // },
                    // '/auth/login': (BuildContext context) {
                    //   bootstrapOpenbookProviderInContext(context);
                    //   return OBAuthLoginPage();
                    // },
                    '/waitlist/subscribe_email_step': (BuildContext context) {
                      bootstrapOpenbookProviderInContext(context);
                      return OBWaitlistSubscribePage();
                    },
                    '/waitlist/subscribe_done_step': (BuildContext context) {
                      bootstrapOpenbookProviderInContext(context);
                      WaitlistSubscribeArguments args = ModalRoute.of(context)!
                          .settings
                          .arguments as WaitlistSubscribeArguments;
                      return OBWaitlistSubscribeDoneStep(count: args.count!);
                    },
                    '/policy/policy': (BuildContext context) {
                      bootstrapOpenbookProviderInContext(context);
                      return OBPrivacyPolicyPage();
                    },
                  }),
            ),
          ),
        );
      });
    });
  }

  void bootstrapOpenbookProviderInContext(BuildContext context) {
    var openbookProvider = OpenbookProvider.of(context);
    var localizationService = LocalizationService.of(context);
    if (this.locale!.languageCode !=
        localizationService.getLocale().languageCode) {
      Future.delayed(Duration(milliseconds: 0), () {
        MyApp.setLocale(context, this.locale);
      });
    }
    openbookProvider.setLocalizationService(localizationService);
    UniversalLinksService universalLinksService =
        openbookProvider.universalLinksService;
    universalLinksService.digestLinksWithContext(context);
    openbookProvider.validationService
        .setLocalizationService(localizationService);
    openbookProvider.shareService.setContext(context);
    ScreenUtil.init(context);
  }
}

bool get isOnDesktop {
  return Platform.isLinux || Platform.isMacOS || Platform.isWindows;
}

TextTheme _defaultTextTheme() {
  // This text theme is merged with the default theme in the `TextData`
  // constructor. This makes sure that the emoji font is used as fallback for
  // every text that uses the default theme.
  var style = GoogleFonts.montserrat();
  if (isOnDesktop) {
    style = style.apply(fontFamilyFallback: ['Emoji']);
  }

  return new TextTheme(
    bodyText2: style,
    bodyText1: style,
    button: style,
    caption: style,
    headline4: style,
    headline3: style,
    headline2: style,
    headline1: style,
    headline5: style,
    overline: style,
    subtitle1: style,
    subtitle2: style,
    headline6: style,
  );
}
