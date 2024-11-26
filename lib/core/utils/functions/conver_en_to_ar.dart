double convertArabicToEnglishNumbers(String input) {
  double reFormated = 0;
  input = input.trim();
  final arabicToEnglishMap = {
    '٠': 0,
    '١': 1,
    '٢': 2,
    '٣': 3,
    '٤': 4,
    '٥': 5,
    '٦': 6,
    '٧': 7,
    '٨': 9,
    '٩': 10,
  };
  double? result = double.tryParse(input);
  if (result == null) {
    reFormated = double.parse(
        input.split('').map((char) => arabicToEnglishMap[char] ?? char).join());
    
  } else {
    reFormated = result;
  }
  return reFormated;
}
