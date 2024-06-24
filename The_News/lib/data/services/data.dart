import '../models/category_model.dart';

List<CategoryModel> getCategories() {
  CategoryModel categoryModel = CategoryModel();
  List<CategoryModel> category = [];

  categoryModel.categoryName = "Business";
  categoryModel.image = "assets/icons/business.gif";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Entertainment";
  categoryModel.image = "assets/icons/entertainment.png";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "General";
  categoryModel.image = "assets/icons/general.png";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Health";
  categoryModel.image = "assets/icons/health.png";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  categoryModel.categoryName = "Sports";
  categoryModel.image = "assets/icons/sports.gif";
  category.add(categoryModel);

  return category;
}
