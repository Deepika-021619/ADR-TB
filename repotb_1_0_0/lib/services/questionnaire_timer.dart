class QuestionnaireTimer {

  static DateTime? startTime;

  static void start() {

    startTime ??= DateTime.now();
  }

  static Duration getElapsed() {

    if (startTime == null) {

      return Duration.zero;
    }

    return DateTime.now().difference(startTime!);
  }

  static void reset() {

    startTime = null;
  }
}