class SleepTime {
  String? Period = DateTime.now().hour >= 12 ? "PM" : "AM"; // AM or PM
  int? Hour = DateTime.now().hour; // Hour of the day
  int? Minute = DateTime.now().minute; // Minute
}
