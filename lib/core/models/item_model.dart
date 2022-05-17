class Item {
  String name;
  double price;
  String? imgURL;
  String description;
  int? count;
  String? category;
  double? total;
  String? id;
  List<String>? tags;

  Item(
      {required this.name,
      required this.price,
      this.imgURL,
      this.total = 0,
      this.description = "",
      this.count = 1,
      this.category = "all",
      required this.id,
      this.tags});
}
