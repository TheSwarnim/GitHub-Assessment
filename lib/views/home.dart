import 'package:flutter/material.dart';

import '../model/repo_details.dart';
import '../services/github_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<RepoDetails?>? repoDetails;

  @override
  void initState() {
    super.initState();

    getRepoDetails();
  }

  void getRepoDetails() async {
    repoDetails = await GithubService().getRepos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // create a refresh indicator list view
      body: RefreshIndicator(
        onRefresh: () async {
          // refresh the list
          // wait for 1 sec
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView.builder(
          // render the list of repo_details using github_service on material card
          itemCount: repoDetails?.length ?? 0,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(repoDetails?[index]?.name ?? ''),
              subtitle: Text(repoDetails?[index]?.description ?? ''),
            );
          },
        ),
      ),
    );
  }
}
