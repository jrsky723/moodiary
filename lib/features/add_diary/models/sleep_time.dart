class SleepTime {
  String? _period; // AM or PM
  int? _hour;
  int? _minute; // Minute

  SleepTime() {
    int? hour = DateTime.now().hour;
    _hour = hour > 12 ? hour - 12 : hour; // Hour
    _period = hour >= 12 && hour < 24 ? "PM" : "AM";
    _minute = DateTime.now().minute; // Minute
  }
  String get period => _period!;
  int get hour => _hour!;
  int get minute => _minute!;

  set period(String value) {
    _period = value;
  }

  set hour(int value) {
    _hour = value;
  }

  set minute(int value) {
    _minute = value;
  }
}
