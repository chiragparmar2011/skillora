class AppConstants {
  static const String appName = 'Skillora Instructor';
  static const String appVersion = '1.0.0';

  static String currencySymbol = '\$';
  static String currencyCode = "USD";
  static String merchantCountryCode = 'US';
  static String merchantDisplayName = 'Skillora Instructor Studio';

  /// Roles
  static const String instructor = 'instructor';
  static const String user = 'user';

  /// Preference & State Keys
  static const String authToken = 'instructor_auth_token';
  static const String instructorInfo = 'instructor_info';
  static const String languageKey = 'instructor_lang_key';
  static const String digitalSignature = 'instructor_digital_signature';

  /// Navigation & Route Argument Keys
  static const String courseId = 'courseId';
  static const String questionId = 'questionId';
  static const String lessonId = 'lessonId';
  static const String isEdit = 'isEdit';
}
