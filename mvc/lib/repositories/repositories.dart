//O repositories é aonde se declara o tratamento de leitura dos objetos do aplicativo
//É o segundo arquivo-fonte a ser feito
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:mvcflutter/models/models.dart';
import 'package:path_provider/path_provider.dart';

class ToDoRepository{
  Future<String> get _localPath async{  //Método que retorna o diretório aonde o arquivo de dados está
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async{  //Método que retorna o arquivo de dados
    final path = await _localPath;
    return File('$path/data.json');
  }

  Future<List<ToDoItem>> readData() async{  //Método que lê o arquivo de dados
    try {
      final file = await _localFile;
      String dataJson = await file.readAsString();

      List<ToDoItem> data = (json.decode(dataJson) as List)
          .map((i) => ToDoItem.fromJson(i)).toList();
      return data;
    }
    catch(e){
        return List<ToDoItem>();
    }
  }

  Future<bool> saveData(List<ToDoItem> list) async{
    try{
      final file = await _localFile;
      final String data = json.encode(list);
      file.writeAsString(data);
      return true;
    }
    catch(e){
      return false;
    }
  }

}

