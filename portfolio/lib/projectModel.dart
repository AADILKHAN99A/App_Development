// To parse this JSON data, do
//
//     final projects = projectsFromJson(jsonString);

import 'dart:convert';

Projects projectsFromJson(String str) => Projects.fromJson(json.decode(str));

String projectsToJson(Projects data) => json.encode(data.toJson());

class Projects {
  List<Project> projects;

  Projects({
    required this.projects,
  });

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
    projects: List<Project>.from(json["projects"].map((x) => Project.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "projects": List<dynamic>.from(projects.map((x) => x.toJson())),
  };
}

class Project {
  String name;
  String description;
  String technology;
  String mainImage;
  List<String> responsiveImages;
  String github;
  String direction;

  Project({
    required this.name,
    required this.description,
    required this.technology,
    required this.mainImage,
    required this.responsiveImages,
    required this.github,
    required this.direction,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    name: json["name"],
    description: json["description"],
    technology: json["technology"],
    mainImage: json["main_image"],
    responsiveImages: List<String>.from(json["responsiveImages"].map((x) => x)),
    github: json["github"],
    direction: json["direction"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "technology": technology,
    "main_image": mainImage,
    "responsiveImages": List<dynamic>.from(responsiveImages.map((x) => x)),
    "github": github,
    "direction": direction,
  };
}
