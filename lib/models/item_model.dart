class ItemModel {
  ItemModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.birthday,
  });

  final String id;
  final String name;
  final String phoneNumber;
  final DateTime birthday;

  String daysUntilNextBirthday() {
    final now = DateTime.now();
    final nextBirthday = DateTime(now.year, birthday.month, birthday.day);
    if (nextBirthday.isBefore(now)) {
      return nextBirthday.add(const Duration(days: 365)).difference(now).inDays.toString();
    } else {
      return nextBirthday.difference(now).inDays.toString();
    }
  }
}
