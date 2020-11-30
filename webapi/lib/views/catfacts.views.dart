import 'package:flutter/material.dart';
import 'package:webapiflutter/controllers/catfacts.controller.dart';
import 'package:webapiflutter/repositories/catfacts.repositories.dart';
import 'package:webapiflutter/models/catfacts.models.dart';

class CatFactsView extends StatefulWidget{
  @override
  _CatFactsViewState createState() => _CatFactsViewState();
}

class _CatFactsViewState extends State<CatFactsView>{
  Future<CatFacts> futureFacts;
  var _controller = CatFactsController();

  @override
  void initState(){
    super.initState();
    futureFacts = _controller.getCatFacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cat Facts!'), centerTitle: true, backgroundColor: Colors.lightBlue,),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(25.0),
        child: FutureBuilder<CatFacts>(
          future: futureFacts,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Text("${snapshot.data.text}", style: TextStyle(fontSize: 20), textAlign: TextAlign.center,);
            } else if(snapshot.hasError){
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        )
      ),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.refresh),
      backgroundColor: Colors.blueAccent,
      elevation: 0,
      onPressed: () => _refresh(context),
    ), floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _refresh(context) async{
    var update = _controller.getCatFacts();
    setState(() {
      futureFacts = update;
    });
  }
}