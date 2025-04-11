extension DurationIntExtension on int {
  Duration get minute => Duration(minutes: this);

  Duration get second => Duration(seconds: this);

  Duration get millisecond => Duration(milliseconds: this);
}
