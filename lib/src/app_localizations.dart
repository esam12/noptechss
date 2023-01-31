import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

//import 'l10n/messages_all.dart';
class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appName': 'Noptechs',
      'domain': 'Domain',
      'db': 'Database',
      'domainRequired': 'Domain is required.',
      'databaseRequired': 'Database is required.',
      'domainValid': 'Plase enter a valid domain.',
      'userName': 'User Name (Email)',
      'userNameRequired': 'User Name (Email) is required.',
      'password': 'Password',
      'passwordRequired': 'Password is required',
      'saveDomain': 'Remember me ?',
      'login': 'Login',
      'ok': 'Okay',
      'error': 'Error!',
      'errorWentWrong': 'Something went wrong the please try again.',
      'noInternet': 'No Internet Connection',
      'noInternetMessage': 'No Internet Connection please try again.',
      'onlyNoptechs': 'this app is only for noptechs erp',
      'userNamePwdInvalid': 'UserName or password is incorrect.',
      'noDatabaseFound': 'No Database found in this domain.',
      'more1Database': 'more than one database found.',
      'noptechsErp': 'Noptechs ERP',
      'logout': 'Logout',
      'noBackHistory': 'No back history item',
      'noForwardHistory': 'No forward history item',
      'errorContactAdmin':
          'There is some error processing your request please contact the admin',
      'onlyWebImg': 'Sorry you can\'t change the image form your phone.',
      'alreadExists': 'Users with same name is already exists.',
      'pleaseWait': 'Please wait...',
      'fullName': 'Full Name',
      'fullNameRequired': 'Full name is required.',
      'passwordLength': 'The password is too short (8 charactors)',
      'confirmPassword': 'Confirm Password',
      'confirmPasswordMatch': 'Confirm Password must match password',
      'haveAccount': 'Already have an account ?',
      'signUp': 'Sign up',
      'noAccount': 'Don\'t have an account ?',
      'restPassword': 'Reset Password',
      'backToLogin': 'Back to Login',
      'sendResetEmail': 'Send Reset Email',
      'invalidUserEmail': 'Invalid user name or email.',
      'emailSendWithReset':
          'An email has been sent with credentials to reset your password.',
      'yourAccounts': 'Your accounts',
    },
    'ar': {
      'appName': 'Noptechs',
      'domain': 'اسم النطاق',
      'db': 'اسم قاعدة البيانات',
      'domainRequired': 'اسم النطاق مطلوب',
      'databaseRequired': 'اسم قاعدة البيانات مطلوب',
      'domainValid': 'يردجي إدخال اسم نطاق صحيح',
      'userName': 'اسم المستخدم(البريد)',
      'userNameRequired': 'اسم المستخدم(البريد) مطلوب',
      'password': 'كلمة المرور',
      'passwordRequired': 'يرجي إدخال كلمة المرور',
      'saveDomain': 'حفظ معلومات الدخول ؟',
      'login': 'تسجل الدخول',
      'ok': 'موافق',
      'error': 'خطا !',
      'errorWentWrong': 'حصل خطأ ما يرجي المحاولة مرة اخري.',
      'noInternet': 'لا يوجد اتصال',
      'noInternetMessage':
          'لايوجد اتصال بشبكة الانترنت يرجي الاتصال و  المحاولة مرة اخري.',
      'onlyNoptechs': 'هذا التطبيق فقط لي نوبتيكس',
      'userNamePwdInvalid': 'إسم المستخدم او كلمة المرور غير صحيحة',
      'noDatabaseFound': 'لاتوجد قاعدة بيانات في هذا النطاق',
      'more1Database': 'اكثر من قاعدة بيانات',
      'noptechsErp': 'نوبتكس ERP',
      'logout': 'تسجيل خروج',
      'noBackHistory': 'لايمكن الرجوع الي الوراء',
      'noForwardHistory': 'لايمكن الذهاب الي الامام .',
      'errorContactAdmin': 'يوجد خطأ يرجي الاتصال بمدير النظام',
      'onlyWebImg': 'لا تستطيع تعير الصورة من الهاتف',
      'alreadExists': 'يوجد مستخدم بنفس الاسم',
      'pleaseWait': 'الرجاء الانتظار',
      'fullName': 'الاسم الكامل',
      'fullNameRequired': 'الاسم الكامل مطلوب',
      'passwordLength': 'كلمة المرور قصيرة يرجي ادخال 8 احرف',
      'confirmPassword': 'تأكيد كلمة المرور',
      'confirmPasswordMatch': 'تأكيد كلمة المرور يجب ان تطابق كلمة المرور',
      'haveAccount': 'لدي حساب مسبقاٌ',
      'signUp': 'تسجيل',
      'noAccount': 'ليس لدي حساب',
      'restPassword': 'استعادة كلمة المرور',
      'backToLogin': 'العودة لتسجيل الدخول',
      'sendResetEmail': 'إستعادة كلمة المرور',
      'invalidUserEmail': 'اسم المستخدم أو البريد الإلكتروني غير صالح',
      'emailSendWithReset':
          'تم إرسالة رسالة بريد إلكتروني بالبيانات اللازمة لإعادة تعيين كلمة المرور الخاصة بك',
      'yourAccounts': 'حساباتك',
    },
  };

  String get appName => _localizedValues[locale.languageCode]!['appName']!;
  String get domain => _localizedValues[locale.languageCode]!['domain']!;
  String get db => _localizedValues[locale.languageCode]!['db']!;
  String get domainRequired =>
      _localizedValues[locale.languageCode]!['domainRequired']!;
  String get databaseRequired =>
      _localizedValues[locale.languageCode]!['databaseRequired']!;
  String get domainValid =>
      _localizedValues[locale.languageCode]!['domainValid']!;
  String get userName => _localizedValues[locale.languageCode]!['userName']!;
  String get userNameRequired =>
      _localizedValues[locale.languageCode]!['userNameRequired']!;
  String get password => _localizedValues[locale.languageCode]!['password']!;
  String get passwordRequired =>
      _localizedValues[locale.languageCode]!['passwordRequired']!;
  String get saveDomain =>
      _localizedValues[locale.languageCode]!['saveDomain']!;
  String get login => _localizedValues[locale.languageCode]!['login']!;
  String get ok => _localizedValues[locale.languageCode]!['ok']!;
  String get error => _localizedValues[locale.languageCode]!['error']!;
  String get errorWentWrong =>
      _localizedValues[locale.languageCode]!['errorWentWrong']!;
  String get noInternet =>
      _localizedValues[locale.languageCode]!['noInternet']!;
  String get noInternetMessage =>
      _localizedValues[locale.languageCode]!['noInternetMessage']!;
  String get onlyNoptechs =>
      _localizedValues[locale.languageCode]!['onlyNoptechs']!;
  String get userNamePwdInvalid =>
      _localizedValues[locale.languageCode]!['userNamePwdInvalid']!;
  String get noDatabaseFound =>
      _localizedValues[locale.languageCode]!['noDatabaseFound']!;
  String get more1Database =>
      _localizedValues[locale.languageCode]!['more1Database']!;
  String get noptechsErp =>
      _localizedValues[locale.languageCode]!['noptechsErp']!;
  String get logout => _localizedValues[locale.languageCode]!['logout']!;
  String get noBackHistory =>
      _localizedValues[locale.languageCode]!['noBackHistory']!;
  String get noForwardHistory =>
      _localizedValues[locale.languageCode]!['noForwardHistory']!;
  String get errorContactAdmin =>
      _localizedValues[locale.languageCode]!['errorContactAdmin']!;
  String get onlyWebImg =>
      _localizedValues[locale.languageCode]!['onlyWebImg']!;
  String get alreadExists =>
      _localizedValues[locale.languageCode]!['alreadExists']!;
  String get pleaseWait =>
      _localizedValues[locale.languageCode]!['pleaseWait']!;
  String get fullName => _localizedValues[locale.languageCode]!['fullName']!;
  String get fullNameRequired =>
      _localizedValues[locale.languageCode]!['fullNameRequired']!;
  String get passwordLength =>
      _localizedValues[locale.languageCode]!['passwordLength']!;
  String get confirmPassword =>
      _localizedValues[locale.languageCode]!['confirmPassword']!;
  String get confirmPasswordMatch =>
      _localizedValues[locale.languageCode]!['confirmPasswordMatch']!;
  String get haveAccount =>
      _localizedValues[locale.languageCode]!['haveAccount']!;
  String get signUp => _localizedValues[locale.languageCode]!['signUp']!;
  String get noAccount => _localizedValues[locale.languageCode]!['noAccount']!;
  String get restPassword =>
      _localizedValues[locale.languageCode]!['restPassword']!;
  String get backToLogin =>
      _localizedValues[locale.languageCode]!['backToLogin']!;
  String get sendResetEmail =>
      _localizedValues[locale.languageCode]!['sendResetEmail']!;
  String get invalidUserEmail =>
      _localizedValues[locale.languageCode]!['invalidUserEmail']!;
  String get emailSendWithReset =>
      _localizedValues[locale.languageCode]!['emailSendWithReset']!;
  String get yourAccounts =>
      _localizedValues[locale.languageCode]!['yourAccounts']!;
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
