import '../../shared_preference.dart';

class RegistrationSharedPrefRepository {
   Future<bool> publicSharedRegister({String email, String password, String cpassword}) async{
    await CacheHelper.init();
    await CacheHelper.putUserNameFromSharedPreference(email).then((value) =>
            CacheHelper.putPasswordFromSharedPreference(password).then(
                (value) {
                  return value ;
                })
    );
    return false ;
  }
}
