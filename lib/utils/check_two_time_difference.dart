// Helper function to parse time strings (HH:mm AM/PM) into DateTime
DateTime parseTime(String time) {
  final now = DateTime.now(); // Use the current date
  final timeParts = time.split(' '); // Separate the time and AM/PM
  final hourMinuteParts = timeParts[0].split(':'); // Split hours and minutes

  int hours = int.parse(hourMinuteParts[0]);
  int minutes = int.parse(hourMinuteParts[1]);

  // Adjust hours for PM (add 12 unless it's 12 PM) or AM (handle 12 AM as 0)
  if (timeParts[1].toUpperCase() == 'PM' && hours != 12) {
    hours += 12;
  } else if (timeParts[1].toUpperCase() == 'AM' && hours == 12) {
    hours = 0;
  }

  return DateTime(now.year, now.month, now.day, hours, minutes);
}

Duration calculateTimeDifference(String startTime, String endTime) {
  DateTime startDateTime = parseTime(startTime);
  DateTime endDateTime = parseTime(endTime);

  // Adjust endDateTime if it is the next day
  if (endDateTime.isBefore(startDateTime)) {
    endDateTime = endDateTime.add(const Duration(days: 1));
  }

  return endDateTime.difference(startDateTime);
}
