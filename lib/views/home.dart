import 'package:flutter/material.dart';
import 'package:github_repo/util.dart';

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
      if (repoDetails != null) {
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
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // add language, github stars, and forks
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 10,
                              color: Util.createUniqueColorForEachLanguage(repoDetails?[index]?.language),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              repoDetails?[index]?.language ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text(
                              repoDetails?[index]?.stargazersCount.toString() ?? '0',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.call_split,
                              color: Colors.blue,
                            ),
                            Text(
                              repoDetails?[index]?.forks.toString() ?? '0',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child:
                        CommitView(repoName: repoDetails?[index]?.name ?? ''),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
