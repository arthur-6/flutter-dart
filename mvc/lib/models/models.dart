//Models é aonde se vai declarar as classes necessárias para o funcionamento do app
//É o primeiro dos arquivos-fonte a ser feito
class ToDoItem{  //Declarando a classe e suas variáveis
  String taskName;
  bool taskStatus;

  ToDoItem({this.taskName, this.taskStatus});

  ToDoItem.fromJson(Map<String, dynamic> json){  //Convertendo do json para classe
    taskName = json['taskName'];
    taskStatus = json['taskStatus'];
  }

  Map<String, dynamic> toJson(){  //Convertendo da classe pro json
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskName'] =  this.taskName;
    data['taskStatus'] = this.taskStatus;
    return data;
  }
}