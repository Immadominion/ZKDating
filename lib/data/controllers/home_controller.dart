import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'base_controller.dart';

final zkDatingHomeController =
    ChangeNotifierProvider<HomePageController>((ref) => HomePageController());

class HomePageController extends BaseChangeNotifier {
 int _activeTab = 0;
  int get activeTab => _activeTab;

  set activeTab(int index) {
    _activeTab = index;
    notifyListeners(); // Important: Notify listeners of the change
  }

}
