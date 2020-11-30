import 'dart:convert';
import 'package:webapiflutter/models/catfacts.models.dart';
import 'package:http/http.dart' as http;

class CatFactsRepository{
  var url = 'https://cat-fact.herokuapp.com/facts/random?amount=1';

  Future<CatFacts> getCatFacts() async{
    final response = await http.get(url);
    print(response.body);
    if(response.statusCode == 200){
      CatFacts data = CatFacts.fromJson(json.decode(response.body));
      print(data.text);
      return data;
    }
    else{
      throw Exception("Erro de conexão com o servidor.");
    }
  }
}