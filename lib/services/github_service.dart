import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/commit_details.dart';
import '../model/repo_details.dart';

class GithubService {
  final Dio _dio = Dio();

  // get the list of repositories using RepoDetails model
  Future<List<RepoDetails?>?> getRepos() async {
    try {
      // hit api with the response of the list of repo_details

      final response = await _dio.get<List<RepoDetails>>
        ('https://api.github.com/users/freeCodeCamp/repos');
      if (kDebugMode) {
        print(response.data);
      }
      return response.data;
    } on DioError catch (e) {
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
      final response = await _dio.get<List<CommitDetails>>
        ('https://api.github.com/repos/freeCodeCamp/$repoName/commits');
      if (kDebugMode) {
        print(response.data);
      }
      return response.data;
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}