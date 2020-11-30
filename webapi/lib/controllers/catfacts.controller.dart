import 'dart:convert';
import 'package:webapiflutter/models/catfacts.models.dart';
import 'package:webapiflutter/repositories/catfacts.repositories.dart';

class CatFactsController{
  CatFactsRepository repository = new CatFactsRepository();
  CatFacts data = CatFacts();

  Future<CatFacts> getCatFacts() async{
    try{
      CatFacts data = await repository.getCatFacts();
      return data;
    }
    catch(e){
      print("Erro:" + e.toString());
    }
  }
}