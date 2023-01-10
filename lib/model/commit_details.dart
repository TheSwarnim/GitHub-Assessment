/*
sample example
[
  {
    "commit": {
      "author": {
        "name": "septimus",
        "date": "2015-08-03T06:20:07Z"
      },
      "committer": {
        "name": "septimus",
        "date": "2015-08-03T06:20:07Z"
      },
      "message": "Added touch support to the rest of the game. Made it so campers and peas that go off the screen are cleaned up.",
    }
  }
]
* */

import 'dart:convert';

List<CommitDetails?>? commitDetailsFromJson(String str) =>
    json.decode(str) == null
        ? []
        : List<CommitDetails?>.from(
            json.decode(str)!.map((x) => CommitDetails.fromJson(x)));

class CommitDetails {
  String ?authorName;
  DateTime ?authorDate;
  String ?committerName;
  DateTime ?committerDate;
  String ?message;

  CommitDetails({
    this.authorName,
    this.authorDate,
    this.committerName,
    this.committerDate,
    this.message,
  });

  factory CommitDetails.fromJson(Map<String, dynamic> json) => CommitDetails(
    authorName: json["commit"]["author"]["name"],
    authorDate: DateTime.parse(json["commit"]["author"]["date"]),
    committerName: json["commit"]["committer"]["name"],
    committerDate: DateTime.parse(json["commit"]["committer"]["date"]),
    message: json["commit"]["message"],
  );

  Map<String, dynamic> toJson() => {
    "authorName": authorName,
    "authorDate": authorDate,
    "committerName": committerName,
    "committerDate": committerDate,
    "message": message,
  };

}