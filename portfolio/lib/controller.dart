import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:portfolio/projectModel.dart';
import 'package:portfolio/remote_config/remote.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MyController extends GetxController {
  static MyController get instance => Get.find();

  var firebaseStorage = FirebaseStorage.instance.ref();
  var _resumeImage = ''.obs;

  get resumeImage => _resumeImage;
  var _resumeLink = ''.obs;

  get resumeLink => _resumeLink;
  var projectData = <Project>[].obs;

  updateAllData() {
    _resumeImage = RemoteData().getString(RemoteKeys.resumeImageLink).obs;

    _resumeLink = RemoteData().getString(RemoteKeys.resumeLink).obs;

    var projects = RemoteData().getProject(RemoteKeys.projectData);

    listAllProjects(projects);
    listAllImages();
  }

  void listAllProjects(Projects projects) {
    for (var project in projects.projects) {
      projectData.add(project);
    }
  }

  void convert() {
    String fileId = _resumeImage.substring(
        _resumeImage.indexOf('/d/') + 3, _resumeImage.indexOf('/view'));

    var newLink = 'https://drive.google.com/uc?export=view&id=$fileId'.obs;
    _resumeImage = newLink;
  }

  int lastValue = 0;

  void listAllImages() async {
    for (var project in projectData) {
      int index = 0;
      for (var i in project.responsiveImages) {
        var imgName = (index+1).toString();

        String? url = await getImage(imgName, project.mainImage);


        project.responsiveImages[index++] = url;
      }
    }
    print(projectData[0].name);
    print(projectData[0].responsiveImages.toString());
  }

  Future<String> getImage(String? imgName, String? projectName) async {
    if (imgName == null || projectName == null) {
      return "";
    }

    try {
      var urlRef = firebaseStorage
          .child("Projects")
          .child(projectName)
          .child("$imgName.png");
      var imgUrl = await urlRef.getDownloadURL();

      return imgUrl;
    } catch (e) {
      return "";
    }
  }
}
