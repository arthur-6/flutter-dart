import 'package:flutter/material.dart';

//o main chama uma função runApp, que roda o MaterialApp com dados requisitos e declara que a home
//do app é HomeApp()
void main() => runApp(MaterialApp(
  title: 'Lista de Compras',
  debugShowCheckedModeBanner: false,
  home: HomeApp(),
));

//HomeApp declara que ListApp utiliza de um construtor para criar seu estado
class HomeApp extends StatefulWidget{
  @override
  ListApp createState() => ListApp();
}

//aonde o app inteiro fica
class ListApp extends State<HomeApp>{
    @override

    //declaração de variáveis
    final _formulario = GlobalKey<FormState>();  //Formulário
    var _itemController = TextEditingController();  //Controlador dos inputs
    List _lista = [];  //Vetor da lista

    Widget build(BuildContext context){
      return MaterialApp(
        theme: ThemeData(primaryColor: Colors.lightGreenAccent),
        home: Scaffold(
          appBar: AppBar(title: Text('Lista de Compras'), centerTitle: true),
          body: Scrollbar(child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              for(int i = 0; i < _lista.length; i++)
                ListTile(
                  leading: ExcludeSemantics(
                    child: CircleAvatar(child: Text('${i + 1}')), //Marcador circular da posição na lista
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _lista[i].toString(),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 20.0,
                          color: Colors.red,
                        ),
                        onPressed: (){ //Quando o botão com o ícone de delete for pressionado, deletará o item referente
                          setState(() {
                            _lista.removeAt(i);
                          }); //Função setState
                        }, //Função onPressed
                      )
                    ], //Children (title)
                  ),
                )
            ],
          )),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.green,
            onPressed: () => _dialogForm(context),
          ),
        )
      );
    }

    _dialogForm(context) async{ //Função que roda quando o botão de + for pressionado
      return showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Form(
            key: _formulario,
            child: TextFormField(
              controller: _itemController,
              validator: (s){
                if(s.isEmpty) //Caso s esteja vazio
                  return "Digite o item";
                else
                  return null;
              }, //Função do validator
              keyboardType: TextInputType.text, //Tipo do teclado de entrada
              decoration: InputDecoration(labelText: "Item"), //"Subtexto" do input
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: new Text('Cancelar'),
              color: Colors.red,
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text('Salvar'),
              textColor: Colors.white,
              color: Colors.greenAccent,
              onPressed: (){
                if(_formulario.currentState.validate()){
                  setState(() {
                    _lista.add(_itemController.text);
                    _itemController.text = "";
                  });
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      });
    }
}
