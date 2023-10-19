import 'dart:io';

class ConsoleService {
  const ConsoleService();

  bool printAllCodes() {
    print('1 - выводить все найденные коды при нескольких результатах');
    print('0 - выводить пустые строки вместо них');
    do {
      final input = stdin.readLineSync();
      if (input != null) {
        if (input == '1') return true;
        if (input == '0') return false;
      }
      print('Введите число');
    } while (true);
  }
}
