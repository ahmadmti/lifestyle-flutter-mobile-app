class DietPlanData{

  String title;
  String description;
  String howtouse;
  String image1;
  String name1;
  String image2;
  String name2;
  String image3;
  String name3;


  DietPlanData(this.title,this.description,this.howtouse, this.image1, this.name1, this.image2, this.name2, this.image3, this.name3);

  DietPlanData.fromJson(Map<String, dynamic> json) :
        title= json['title'],
        description= json['description'],
        howtouse= json['howtouse'],
        image1= json['image1'],
        name1= json['name1'],
        image2= json['image2'],
        name2= json['name2'],
        image3= json['image3'],
        name3= json['name3'];

  toJson() {
    return {
      "title": title,
      "description": description,
      "howtouse": howtouse,
      "image1": image1,
      "name1": name1,
      "image2": image2,
      "name2": name2,
      "image3": image3,
      "name3": name3,
    };
  }



}