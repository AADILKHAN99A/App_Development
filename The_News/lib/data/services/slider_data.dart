import '../models/slider_model.dart';

List<SliderModel> getSliders() {
  SliderModel sliderModel = SliderModel();
  List<SliderModel> slider = [];

  sliderModel.name = "Bow To The Authority of Silenforce";
  sliderModel.image = "assets/images/business.jpg";
  slider.add(sliderModel);
  sliderModel = SliderModel();

  sliderModel.name = "Bow To The Authority of Silenforce";
  sliderModel.image = "assets/images/entertainment.jpg";
  slider.add(sliderModel);
  sliderModel = SliderModel();

  sliderModel.name = "Bow To The Authority of Silenforce";
  sliderModel.image = "assets/images/general.jpg";
  slider.add(sliderModel);
  sliderModel = SliderModel();

  sliderModel.name = "Bow To The Authority of Silenforce";
  sliderModel.image = "assets/images/health.jpg";
  slider.add(sliderModel);
  sliderModel = SliderModel();

  sliderModel.name = "Bow To The Authority of Silenforce";
  sliderModel.image = "assets/images/sports.jpg";
  slider.add(sliderModel);

  return slider;
}
