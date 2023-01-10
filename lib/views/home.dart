import 'package:flutter/material.dart';

import '../model/repo_details.dart';
import '../services/github_service.dart';
import 'commit_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<RepoDetails?>? repoDetails;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    getRepoDetails();
  }

  void getRepoDetails() async {
    repoDetails = await GithubService().getRepos();
    setState(() {
      if(repoDetails != null) {
        isLoaded = true;
      }
    });
  }

  void reloadRepoDetails() async {
    setState(() {
      isLoaded = false;
    });
    getRepoDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // create a refresh indicator list view
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            // refresh the list
            reloadRepoDetails();
          },
          child: ListView.builder(
            // render the list of repo_details using github_service on material card
            itemCount: repoDetails?.length ?? 0,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        repoDetails?[index]?.name ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        repoDetails?[index]?.description ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),

                    const Divider(
                      height: 5,
                      thickness: 0.8,
                      color: Colors.grey,
                      indent: 20,
                      endIndent: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: CommitView(repoName: repoDetails?[index]?.name ?? ''),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
