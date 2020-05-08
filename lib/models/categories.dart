import './category.dart';

class CategoriesModel {
  Map<int, CategoryModel> categories = {};

  CategoriesModel(this.categories);

  addCategory(CategoryModel category) {
    categories[category.id] = category;
  }
}
