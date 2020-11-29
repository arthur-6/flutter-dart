//Na views serão desenvolvidas as telas do aplicativo
//Quarto arquivo-fonte a ser feito.
import 'package:flutter/material.dart';
import 'package:mvcflutter/controllers/controllers.dart';
import 'package:mvcflutter/models/models.dart';

class ToDoListView extends StatefulWidget{
  @override
  _ToDoListViewState createState() => _ToDoListViewState();
}

class _ToDoListViewState extends State<ToDoListView>{
  //Declaração de variáveis
  final _formulario = GlobalKey<FormState>();
  var _itemController = TextEditingController();
  var _list = List<ToDoItem>();
  var _controller = ItemController();

  //Estado inicial do app: carrega os dados da lista no arquivo local
  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      _controller.getAll().then((data){
        setState((){
          _list = _controller.list;
        });
      });
    });
  }

 @override
 Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Scrollbar(
        child: ListView(
          children: [
            for(int j = 0; j < _list.length; j++)
              ListTile(
                title: CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: _list[j].taskStatus?   //Caso o taskStatus seja true, o primeiro valor é referente ao texto do item, caso contrário, o primeiro é aplicado
                      Text(_list[j].taskName, style: TextStyle(decoration: TextDecoration.lineThrough),):
                      Text(_list[j].taskName),
                  value: _list[j].taskStatus,
                  secondary: IconButton(
                    icon: Icon(
                      Icons.delete,
                      size: 20.0,
                      color: Colors.red,
                    ),
                    onPressed: (){
                      _controller.delete(j).then((data){
                        setState((){
                          _list =  _controller.list;
                        });
                      });
                    },
                  ),
                  onChanged: (c){
                    _list[j].taskStatus = c;
                    _controller.updateList(_list).then((data){
                      setState(() {
                        _list = _controller.list;
                      });
                    });
                  },
                ),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        onPressed: () => _displayDialog(context),
      ),
    );
 }

 _displayDialog(context) async {
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Form(
          key: _formulario,
          child: TextFormField(
            controller: _itemController,
            validator: (s){
              if(s.isEmpty)
                return "Digite o item.";
              else
                return null;
            },
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: "Item"),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: new Text('Cancelar'),
            color: Colors.red,
            textColor: Colors.white,
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: new Text('Salvar'),
            color: Colors.lightGreenAccent,
            textColor: Colors.white,
            onPressed: (){
              if(_formulario.currentState.validate()){
                _controller.create(ToDoItem(taskName: _itemController.text, taskStatus: false)).then((data){
                  setState(() {
                    _list = _controller.list;
                    _itemController.text = "";
                  });
                });
                Navigator.of(context).pop();
              }
            },
          )
        ]
      );
    });
 }
}