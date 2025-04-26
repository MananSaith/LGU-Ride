import 'package:flutter/cupertino.dart';
import 'package:riding_app/models/rider.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  RiderModel? _userModel;
  RiderModel? _riderModel;

  void saveUserDetails(RiderModel? userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  void saveRiderData(RiderModel? riderModel) {
    _riderModel = riderModel;
    notifyListeners();
  }

  RiderModel? getUserDetails() => _userModel;

  RiderModel? getRiderDetails() => _riderModel;
}
