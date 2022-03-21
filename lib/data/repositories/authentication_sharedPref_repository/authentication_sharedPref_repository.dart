import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared_preference.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated,
  error,
  loading
}

class AuthenticationSharedPrefRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    yield* _controller.stream;
  }

  Future<bool> logIn(
      {String username, String password, String device}) async {
    await CacheHelper.init();
    dynamic sharedName = await CacheHelper.getUserNameFromSharedPreference();
    if(sharedName != null) {
          // There is a login Name saved in Shared Pref
          if(username == sharedName)
            {
              dynamic sharedPassword = CacheHelper.getPasswordFromSharedPreference();
              return sharedPassword == password ? true : false ;
            }
        }
        else{
          // There is No Name saved in Shared Preference
          return false ;
        }
  }

  Future<bool> register({String email, String password, String cpassword}) async{
    await CacheHelper.init();
    bool name = await CacheHelper.putUserNameFromSharedPreference(email);
    bool pass = await CacheHelper.putPasswordFromSharedPreference(password);
    if(name && pass){
      return true ;
    }
    else{
      return false ;
    }
  }

  Future<bool> forgotPassword({String email}) async{
    await CacheHelper.init();
    dynamic sharedName = await CacheHelper.getUserNameFromSharedPreference();
      if(sharedName != null && sharedName == email)
      {
        return true;
      }
      else {
          return false;
        }
  }

  Future<bool> updatePassword({String password}) async {
    await CacheHelper.init();
    bool pass = await CacheHelper.putPasswordFromSharedPreference(password);
    if(pass) {
      return true ;
    } else {
      return false ;
    }
  }

  logOut(String token) async {
    //do logout api call here
     _controller.add(AuthenticationStatus.unauthenticated);
     await CacheHelper.init();
     await CacheHelper.removePasswordFromSharedPreference();
     await CacheHelper.removeUserNameFromSharedPreference();
  }

  void dispose() => _controller.close();
}
