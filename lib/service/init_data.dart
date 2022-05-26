import 'package:accident_detection/constants.dart';
import 'package:accident_detection/models/user_data.dart';
import 'package:accident_detection/widget/show_error_dialog.dart';

class InitData {
  static UserData? owner;

  Future<InitData> loadInitData() async {
    if (owner != null) {
      return this;
    }
    UserData? user;
    // await FirestoreService().getSingleUser(MyAuth().getCurrentUserId());

    /// if user data not found in mongodb
    if (user == null) {
      bool success = false;
      // await UserAWSSevice().createUser();
      if (success) {
        UserData? usernew;
        // await UserAWSSevice().getSingleUser(MyAuth().getCurrentUserId());
        if (usernew == null) {
          showErrorDialog("Something went wrong", "Please try after sometime");
        } else {
          owner = usernew;
        }
      } else {
        showErrorDialog("Something went wrong", "Please try after sometime");
      }
    } else {
      owner = user;
    }
    kLogger.i(owner);
    return this;
  }

  Future<InitData> reloadOwner() async {
    clearAll();
    loadInitData();
    return this;
  }

  void clearAll() {
    owner = null;
  }
}
