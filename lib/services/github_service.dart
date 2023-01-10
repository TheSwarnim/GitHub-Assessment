import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../model/commit_details.dart';
import '../model/repo_details.dart';

class GithubService {
  final _client = http.Client();
  // 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

  // get the list of repositories using RepoDetails model
  Future<List<RepoDetails?>?> getRepos() async {
    try {
      // hit api with the response of the list of repo_details

      var uri = Uri.parse('https://api.github.com/users/freeCodeCamp/repos');
      var response = await _client.get(uri, headers: {
        'Accept': 'application/vnd.github+json',
        'Authorization':
            'Bearer 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',
      });
      // if (kDebugMode) {
      //   print(response.body);
      // }
      if (response.statusCode == 200) {
        return repoDetailsFromJson(response.body);
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  // get the list of CommitDetails of a repository using CommitDetails model
  Future<List<CommitDetails?>?> getCommits(String repoName) async {
    try {
      // hit api with the response of the list of commit_details
      var uri = Uri.parse(
          'https://api.github.com/repos/freeCodeCamp/$repoName/commits');
      var response = await _client.get(uri, headers: {
        'Accept': 'application/vnd.github+json',
        'Authorization':
            'Bearer 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',
      });
      // if (kDebugMode) {
      //   print(response.body);
      // }
      if (response.statusCode == 200) {
        return commitDetailsFromJson(response.body);
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}
