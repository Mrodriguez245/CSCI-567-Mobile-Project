class Food {
  int id;
  String foodname;

  Food(
      {this.id,
      this.foodname});

  factory Food.fromDatabaseJson(Map<String, dynamic> data) => Food(
      id: data['id'],
      foodname: data['foodname'],
  );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "foodname": this.foodname
      };
}
