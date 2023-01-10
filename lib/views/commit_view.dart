import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github_repo/util.dart';

import '../model/commit_details.dart';
import '../services/github_service.dart';

// create a stateful widget CommitView that will take a repoName string in its constructor
class CommitView extends StatefulWidget {
  final String repoName;

  const CommitView({Key? key, required this.repoName}) : super(key: key);

  @override
  State<CommitView> createState() => _CommitViewState();
}

class _CommitViewState extends State<CommitView> {
  Timer? timer;
  List<CommitDetails?>? commitDetails;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      getCommitDetails();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void getCommitDetails() async {
    // get the list of commit_details using github_service
    commitDetails = await GithubService().getCommits(widget.repoName);
    setState(() { });
  }

  String formatDate(DateTime? date) {
    // Jun 20, 2022
    return '${date?.day}, ${date?.month}, ${date?.year}';
  }

  @override
  Widget build(BuildContext context) {
   // return container widget if commitDetails list is null or empty
    return commitDetails == null || commitDetails?.isEmpty == true
        ? const Center(
            child: Text('No commits found'),
          )
        : Column(
        children: [
          Row(
            children: const [
              Icon(
                Icons.commit,
                color: Colors.black,
                size: 20,
              ),
              Text(
                ' Latest Commits',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Text(
              Util.removeWhiteSpaces(commitDetails?[0]?.message)
          ),
          if(commitDetails?[0]?.authorName != null && commitDetails?[0]?.authorDate != null)
            Row(
              children: [
                Text(commitDetails?[0]?.authorName ?? ''),
                const Text(' committed on '),
                // display date in the format of like  of given datetime commitDetails?[0]?.authorDate
                Text(Util.getFormattedDate(commitDetails?[0]?.authorDate))
              ],
            ),
        ]
    );
  }
}
