String enToBnNumerals(dynamic input) {
  const englishToBengali = {
    '0': '০',
    '1': '১',
    '2': '২',
    '3': '৩',
    '4': '৪',
    '5': '৫',
    '6': '৬',
    '7': '৭',
    '8': '৮',
    '9': '৯',
  };

  // Convert the input to a string
  final inputString = input.toString();

  // Replace each digit with its Bengali equivalent
  return inputString.split('').map((char) => englishToBengali[char] ?? char).join();
}