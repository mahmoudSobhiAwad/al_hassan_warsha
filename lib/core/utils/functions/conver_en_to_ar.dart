String convertToEnglishNumbers(String arabicNumber) {
  if (arabicNumber.isNotEmpty) {
    const arabicToEnglishMap = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };

    return arabicNumber.replaceAllMapped(RegExp(r'[٠-٩]'), (match) {
      return arabicToEnglishMap[match.group(0)!]!;
    });
  }
  return '0';
}

String convertToArabicNumbers(String number) {
  const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  return number.replaceAllMapped(RegExp(r'\d'), (match) {
    int digit = int.parse(match.group(0)!);
    return arabicDigits[digit];
  });
}
