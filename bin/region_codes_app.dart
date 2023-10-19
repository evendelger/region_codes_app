import 'data_provider/data_provider.dart';
import 'repository/repository.dart';
import 'console_service/console_service.dart';

Future<void> main() async {
  final dataProvider = DataProvider();
  final repository = Repository();
  final consoleService = ConsoleService();

  bool printAllCodes = consoleService.printAllCodes();

  final dataMap = await dataProvider.createDataMap();
  final inputDataLines = await dataProvider.readInputFile();
  final outputSink = dataProvider.openWriteFileSink();

  var inputMap = await repository.createInputMap(inputDataLines);
  inputMap = await repository.fillInputMap(inputMap, dataMap);

  for (var locality in inputDataLines) {
    repository.writeCode(locality, outputSink, inputMap, printAllCodes);
  }

  outputSink.close();
}
