import 'package:git_search_rxdart/github_api.dart';
///搜索状态，包含 正在加载、加载错误、没有关键词、搜索结果、结果为空 这几个状态
class SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {}

class SearchNoTerm extends SearchState {}

class SearchPopulated extends SearchState {
  final SearchResult result;

  SearchPopulated(this.result);
}

class SearchEmpty extends SearchState {}