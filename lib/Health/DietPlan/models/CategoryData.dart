class CategoryData{

  String id;
  String name;
  String image;
  String description;
  bool selected=false;

  CategoryData(this.id,this.name,this.image, this.description);

  CategoryData.fromJson(Map<String, dynamic> json) :
      id= json['id'],
      name= json['name'],
      image= json['image'],
      description= json['description'];

  toJson() {
    return {
      "id": id,
      "name": name,
      "image": image,
      "description": description,

    };
  }



}