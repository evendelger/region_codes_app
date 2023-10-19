import 'dart:convert';
import 'dart:io';

class DataProvider {
  const DataProvider();

  static const inputFileName = 'input.txt';
  static const outputFileName = 'output.txt';
  static const kladrFileName = 'KLADR.csv';

  Future<List<String>> readInputFile() async =>
      await File(inputFileName).readAsLines();

  IOSink openWriteFileSink() => File(outputFileName).openWrite();

  Future<Map<String, List<String>>> createDataMap() async {
    var dataMap = <String, List<String>>{};
    final cladrStream = Stream.fromFuture(File(kladrFileName).readAsString())
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
}
