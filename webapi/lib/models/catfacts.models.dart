class CatFacts{
  String text;

  CatFacts({this.text});

  CatFacts.fromJson(Map<String, dynamic> json){
    text = json["text"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["text"] = this.text;
    return data;
  }
}