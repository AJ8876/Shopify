
import 'dart:io';

class Product{
  final String name;
  final String description;
  final int price;
  final int? discountPrice;
  final int sku;
  final String category;
  final String subCategory;
  final int stock;
  final String weight;
  final bool isAvailable;
  final bool isFeatured;
  final String condition;
  final List<File>images;

  Product({
    required this.name,
  required this.description,
  required this.price,
  this.discountPrice,
  required this.sku,
    required this.category,
  required this.subCategory,
  required this.stock,
  required this.weight,
  required this.isAvailable,
  required this.isFeatured,
  required this.condition,
  required this.images,
});
}
