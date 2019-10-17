import 'package:git_search_rxdart/github_api.dart';
import 'package:rxdart/rxdart.dart';
import 'github_state.dart';

class SearchBloc {
    final Sink<String> onTextChanged;
    final Stream<SearchState> state;

    factory SearchBloc(GithubAPI api) {
      final onTextChanged = PublishSubject<String>();

      final state = onTextChanged
      //判断文本内容是否改变，没有则不执行新的搜索
      .distinct()
      //开始搜索之前等待用户250ms键入间隔
      .debounceTime(const Duration(milliseconds: 250))
      //用给定的关键字调用github API，并且转换成State。如果新的关键字输入，flatMapLatest
      //保证先前的搜索结果被删除，因此不用发送旧数据到view
      .switchMap<SearchState>((String term) => _search(term, api))
      .startWith(SearchNoTerm());

      return SearchBloc._(onTextChanged, state);
    }

    SearchBloc._(this.onTextChanged, this.state);

    void dispose() {
      onTextChanged.close();
    }

    static Stream<SearchState> _search(String term, GithubAPI api) async* {
      if(term.isEmpty) {
        yield SearchNoTerm();
      } else {
        yield SearchLoading();

        try {
          final result = await api.search(term);

          if(result.isEmpty) {
            yield SearchEmpty();
          } else {
            yield SearchPopulated(result);
          }

        } catch (e) {
          yield SearchError();
        }
      }
    }
}