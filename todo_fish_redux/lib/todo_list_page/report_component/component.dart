import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

//公告组件，调用buildView创建UI
class ReportComponent extends Component<ReportState> {
  ReportComponent()
      : super(
            view: buildView,
      );

}
