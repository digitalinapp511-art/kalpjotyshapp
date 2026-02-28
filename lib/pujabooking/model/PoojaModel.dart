class PoojaModel {
  String id;
  String name;
  String description;
  String? image;
  int price;
  String enquiryBtn;

  PoojaModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.enquiryBtn,
  });

  factory PoojaModel.fromJson(Map<String, dynamic> json) {
    return PoojaModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      enquiryBtn: json['enquiryBtn'],
    );
  }
}