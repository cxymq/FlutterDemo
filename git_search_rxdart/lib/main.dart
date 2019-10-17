import 'package:flutter/material.dart';
import 'package:git_search_rxdart/github_api.dart';

import 'github_widget.dart';

void main() => runApp(SearchApp(api: GithubAPI()));

class SearchApp extends StatefulWidget {
  final GithubAPI api;

  SearchApp({Key key, this.api}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RxDartGithubSearchAppState();
  }}

class _RxDartGithubSearchAppState extends State<SearchApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RxDart text',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey
      ),
      home: SearchScreen(api: widget.api)
    );
  }
}
