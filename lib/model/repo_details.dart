/*
  RepoDetails class is used to store the details of a repository
  sample example
  [
    {
    "name": "boilerplate-medical-data-visualizer",
    "description": "Cameron working on the stream after the Saturday summit",
    "language": "Python",
    "stargazers_count": 22,
    "watchers_count": 22
    },
    {
    "name": "boilerplate-medical-data-visualizer",
    "description": "Cameron working on the stream after the Saturday summit",
    "language": "Python",
    "stargazers_count": 22,
    "watchers_count": 22
    }
  ]
* */

import 'dart:convert';

List<RepoDetails?>? repoDetailsFromJson(String str) => json.decode(str) == null ? [] : List<RepoDetails?>.from(json.decode(str)!.map((x) => RepoDetails.fromJson(x)));

class RepoDetails {
  RepoDetails({
    this.name,
    this.description,
    this.language,
    this.stargazersCount,
    this.watchersCount,
  });

  String? name;
  String? description;
  String? language;
  int? stargazersCount;
  int? watchersCount;

  factory RepoDetails.fromJson(Map<String, dynamic> json) => RepoDetails(
        name: json["name"],
        description: json["description"],
        language: json["language"],
        stargazersCount: json["stargazers_count"],
        watchersCount: json["watchers_count"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "language": language,
        "stargazers_count": stargazersCount,
        "watchers_count": watchersCount,
      };
}