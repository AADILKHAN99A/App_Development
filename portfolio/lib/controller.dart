import 'package:get/get.dart';
import 'package:portfolio/remote_config/remote.dart';

class MyController extends GetxController {
  var _resumeImage = ''.obs;
  var _resumeLink = ''.obs;

  get resumeImage => _resumeImage;

  get resumeLink => _resumeLink;

  updateResume() {
    _resumeImage = RemoteData().getString(RemoteKeys.resumeImageLink).obs;

    _resumeLink = RemoteData().getString(RemoteKeys.resumeLink).obs;

    print(_resumeLink);

    convert();
  }

  void convert() {
    String fileId = _resumeImage.substring(
        _resumeImage.indexOf('/d/') + 3, _resumeImage.indexOf('/view'));

    var newLink = 'https://drive.google.com/uc?export=view&id=$fileId'.obs;
    _resumeImage = newLink;
    print(_resumeImage);
  }
}
