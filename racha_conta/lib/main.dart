import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  // VARIAVEIS
  final _tConta = TextEditingController();
  final _tAmigos = TextEditingController();
  final _tGarcom = TextEditingController();
  var _infoText = "Informe seus dados!";
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Racha Conta!"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields)
        ],
      ),
      body: _body(),
    );
  }

  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
  void _resetFields(){
    _tConta.text = "";
    _tAmigos.text = "";
    _tGarcom.text = "";
    setState(() {
      _infoText = "Informe os campos acima!";
      _formKey = GlobalKey<FormState>();
    });
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _editText("Quanto ficou a conta?", _tConta),
              _editText("E são quantos amigos?", _tAmigos),
              _editText("Quanto é a porcentagem da gorjeta?", _tGarcom),
              _buttonCalcular(),
              _textInfo()
            ],
          ),
        ));
  }

  // Widget text
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 22,
        color: Colors.red,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.grey,
        ),
      ),
    );
  }

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }

  // Widget button
  _buttonCalcular() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20),
      height: 45,
      child: RaisedButton(
        color: Colors.red,
        child:
        Text(
          "Bora pagar?",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            _calculate();
          }
        },
      ),
    );
  }

  // PROCEDIMENTO PARA CALCULAR A CONTA
  void _calculate(){
    setState(() {
      double total = double.parse(_tConta.text);
      int amigos = int.parse(_tAmigos.text);
      double racha = total / amigos;
      double garcom =  double.parse(_tGarcom.text) / 100;
      double totalGarcom = garcom * total;
      String totalStr = total.toStringAsPrecision(4);
      String rachaStr = racha.toStringAsPrecision(4);
      String totalGarcomStr = totalGarcom.toStringAsPrecision(4);

      _infoText = "O total é de: ($totalStr)\nO quanto que cada um deve pagar é de ($rachaStr)O quanto o garçom deve receber é de ($totalGarcomStr)";

    });
  }

  // // Widget text
  _textInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.red, fontSize: 25.0),
    );
  }
}
