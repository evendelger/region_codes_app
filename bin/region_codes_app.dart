import 'dart:convert';
import 'dart:io';

typedef StringSetMap = Map<String, Set<String>>;
typedef StringListMap = Map<String, List<String>>;
typedef StringIntMap = Map<String, int>;

//
Future<void> main() async {
  bool printAllCodes = _printAllCodes();

  final dataMap = await _createDataMap();
  final inputDataLines = await File('input.txt').readAsLines();
  final outputSink = File('output.txt').openWrite();

  var inputMap = await _createInputMap(inputDataLines);
  inputMap = await _fillInputMap(inputMap, dataMap);

  for (var locality in inputDataLines) {
    _writeCode(locality, outputSink, inputMap, printAllCodes);
  }

  outputSink.close();
}

void _writeCode(
  String locality,
  IOSink outputSink,
  Map<String, Set<String>> inputMap,
  bool printAllCodes,
) {
  final codes = inputMap[locality]!;

  if (codes.length == 1) {
    outputSink.write('${codes.join(' ')}\n');
  } else if (codes.length > 1) {
    final output = printAllCodes ? codes.join(' ') : '';
    outputSink.write('$output\n');
  }
}

Future<StringSetMap> _fillInputMap(
  StringSetMap currentMap,
  StringListMap dataMap,
) async {
  for (var entry in dataMap.entries) {
    for (var locality in entry.value) {
      currentMap.forEach((key, value) {
        if (key == locality) value.add(entry.key);
      });
    }
  }

  return currentMap;
}

Future<StringSetMap> _createInputMap(List<String> inputDataLines) async {
  final inputMap = <String, Set<String>>{};

  for (var line in inputDataLines) {
    inputMap[line] = {};
  }

  return inputMap;
}

bool _printAllCodes() {
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

Future<Map<String, List<String>>> _createDataMap() async {
  var dataMap = <String, List<String>>{};
  final cladrStream = Stream.fromFuture(File('KLADR.csv').readAsString())
      .transform(LineSplitter());

  await for (var line in cladrStream) {
    final row = line.split(';');
    final code = row[0];
    final locality = row[1];

    if (dataMap.containsKey(code)) {
      dataMap[code]?.add(locality);
    } else {
      dataMap[code] = [locality];
    }
  }

  return dataMap;
}
