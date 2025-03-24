import '../utils/bengali_numerals.dart';

class BloodDonor {
  final int id;
  final String name;
  final String dob;
  final String address;
  final String upazilla;
  final String phone;
  final String bloodGroup;
  final String lastDonate;
  final int org;

  BloodDonor({
    required this.id,
    required this.name,
    required this.dob,
    required this.address,
    required this.upazilla,
    required this.phone,
    required this.bloodGroup,
    required this.lastDonate,
    required this.org,
  });

  factory BloodDonor.fromJson(Map<String, dynamic> json) {
    return BloodDonor(
      id: json['id'],
      name: json['name'],
      dob: json['dob'],
      address: json['address'],
      upazilla: json['upazilla'],
      phone: json['phone'],
      bloodGroup: json['bloodGroup'],
      lastDonate: json['lastDonate'],
      org: json['org'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dob': dob,
      'address': address,
      'upazilla': upazilla,
      'phone': phone,
      'bloodGroup': bloodGroup,
      'lastDonate': lastDonate,
      'org': org,
    };
  }

  // Method 1: Check if the last donation was at least 3 months ago
  bool isEligibleToDonate() {
    final lastDonationDate = _parseDate(lastDonate);
    final today = DateTime.now();
    final differenceInMonths = (today.year - lastDonationDate.year) * 12 +
        (today.month - lastDonationDate.month);

    return differenceInMonths >= 3;
  }

  // Method 2: Calculate the number of days since the last donation
  String daysSinceLastDonation() {
  final lastDonationDate = _parseDate(lastDonate);
  final today = DateTime.now();

  // Calculate the difference in years, months, and days
  int years = today.year - lastDonationDate.year;
  int months = today.month - lastDonationDate.month;
  int days = today.day - lastDonationDate.day;

  // Adjust for negative months or days
  if (days < 0) {
    months--;
    days += DateTime(today.year, today.month, 0).day;
  }
  if (months < 0) {
    years--;
    months += 12;
  }

  // Build the result string
  String result = '';
  if (years > 0) {
    result += '${enToBnNumerals(years)} বছর ';
  }
  if (months > 0) {
    result += '${enToBnNumerals(months)} মাস ';
  }
  if (days > 0) {
    result += '${enToBnNumerals(days)} দিন';
  }

  return result.trim(); // Remove any trailing spaces
}

  // Helper method to parse a date string in "dd/MM/yyyy" format
  DateTime _parseDate(String dateString) {
    final parts = dateString.split('/');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }
}