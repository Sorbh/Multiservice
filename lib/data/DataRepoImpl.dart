import 'package:multiservice/data/DataRepo.dart';
import 'package:multiservice/data/prefs/PreferencesManager.dart';

class DataRepoImpl extends DataRepo {
  DataRepoImpl() {
    PreferencesManager.getInstance();
  }


  //############################# SHARED PREFERENCE METHOD##########################
  @override
  bool isUserLogin() {
    return PreferencesManager.getPrefWithDefault(PreferencesManager.IS_LOGIN, false);
  }

}
