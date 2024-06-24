import 'package:flutter/cupertino.dart';

import '../data/models/category_model.dart';
import '../data/models/slider_model.dart';
import '../data/services/data.dart';
import '../data/services/slider_data.dart';

class HomeProvider extends ChangeNotifier {
  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];
  int activeIndex = 0;

  initializeData() {
    categories = getCategories();
    sliders = getSliders();
  }

  updateIndex(int index){
    activeIndex= index;
    notifyListeners();
  }
}
