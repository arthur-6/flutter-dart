//No controllers, serão definidas os métodos que controlam os modelos
//Terceiro arquivo-fonte a ser feito.
import 'package:mvcflutter/models/models.dart';
import 'package:mvcflutter/repositories/repositories.dart';

class ItemController{
  List<ToDoItem> list = new List<ToDoItem>(); //Assoscia um builder para uma lista de ToDoItems
  ToDoRepository repository = new ToDoRepository(); //e um para o repositório de ToDoItems

  Future<void> getAll() async{  //Método para pegar os itens do arquivo de dados em .json salvo localmente
    try {
      final allList = await repository.readData();
      list.clear();
      list.addAll(allList);
      sort();
    }
    catch(e){
     print("Erro:" + e.toString());
    }
  }

  void update() async{  //Procedimento de upddate da lista
    await repository.saveData(list);
    await getAll();
  }

  void sort(){  //Procedimento de organização da lista
    list.sort((a, b) {
        if (a.taskStatus && !b.taskStatus)
          return 1;
        else if (!a.taskStatus && b.taskStatus)
          return -1;
        else
          return 0;
      });
  }

  Future<void> create(ToDoItem item) async{  //Método para criar um item na lista
    try{
      list.add(item);
      await update();
    }
    catch(e){
      print("Erro:" + e.toString());
    }
  }

  Future<void> delete(int i) async{  //Método que deleta o item na posição i da lista
    try{
      list.removeAt(i);
      await update();
    }
    catch(e){
      print("Erro:" + e.toString());
    }
  }

  Future<void> updateList(List<ToDoItem> lista) async{
    await repository.saveData(lista);
    await getAll();
  }
}