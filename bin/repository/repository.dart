import 'dart:io';

typedef StringSetMap = Map<String, Set<String>>;
typedef StringListMap = Map<String, List<String>>;
typedef StringIntMap = Map<String, int>;

class Repository {
  const Repository();

  Future<StringSetMap> fillInputMap(
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

  Future<StringSetMap> createInputMap(List<String> inputDataLines) async {
    final inputMap = <String, Set<String>>{};

    for (var line in inputDataLines) {
      inputMap[line] = {};
    }

    return inputMap;
  }

  void writeCode(
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
}
