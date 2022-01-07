class DataModel {
   int? id;
   String? name;
   String? image;

  DataModel({
     this.id,
     this.name,
     this.image,
  });

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
