import 'package:flutter/material.dart';
import 'package:git_search_rxdart/empty_result_widget.dart';
import 'package:git_search_rxdart/github_api.dart';
import 'package:git_search_rxdart/github_bloc.dart';
import 'package:git_search_rxdart/github_state.dart';
import 'package:git_search_rxdart/search_error_widget.dart';
import 'package:git_search_rxdart/search_intro_widget.dart';
import 'package:git_search_rxdart/search_loading_widget.dart';
import 'package:git_search_rxdart/search_result_widget.dart';

class SearchScreen extends StatefulWidget {
  final GithubAPI api;

  SearchScreen({Key key, this.api}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SearchScreenState();
  }
  
}

class SearchScreenState extends State<SearchScreen> {
  SearchBloc bloc;

  @override
  void initState() {
    super.initState();
//初始化bloc
    bloc = SearchBloc(widget.api);
  }

  @override
  void dispose() {
    //回收bloc
    bloc.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SearchState>(
      stream: bloc.state,
      initialData: SearchNoTerm(),
      builder: (BuildContext context, AsyncSnapshot<SearchState> snapshot) {
        final state = snapshot.data;

        return Scaffold(
          body: Stack(
            children: <Widget>[
              Flex(direction: Axis.vertical, children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '查询github',
                    ),
                    style: TextStyle(
                      fontSize: 36.0,
                      fontFamily: 'Hind',
                      decoration: TextDecoration.none
                    ),
                    onChanged: bloc.textChanged,//bloc.onTextChanged.add,
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildChild(state),
                  ),
                )
              ],)
            ],
          ),
        );
      },
    );
  }
}

Widget _buildChild(SearchState state) {
  if(state is SearchNoTerm) {
    return SearchIntro();
  } else if (state is SearchEmpty) {
    return EmptyWidget();
  } else if (state is SearchLoading) {
    return LoadingWidget();
  } else if (state is SearchError) {
    return SearchErrorWidget();
  } else if (state is SearchPopulated) {
    return SearchResultWidget(items: state.result.items);
  }

  throw Exception('${state.runtimeType} is not supported');
}