import 'package:ecommerce/features/home/data/models/category_model.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ProductModel {
  int? id;
  String? title;
  String? slug;
  int? price;
  String? description;
  CategoryModel? category;
  List<String>? images;
  String? creationAt;
  String? updatedAt;

  ProductModel(
      {this.id,
      this.title,
      this.slug,
      this.price,
      this.description,
      this.category,
      this.images,
      this.creationAt,
      this.updatedAt});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;

    if (json['images'] is List) {
      images = List<String>.from(json['images']);
    } else if (json['images'] is String) {
      images = [json['images']];
    } else {
      images = [];
    }
    creationAt = json['creationAt'];
    updatedAt = json['updatedAt'];
  }
}
