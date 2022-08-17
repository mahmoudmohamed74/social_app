import 'package:social_app/moduels/login/login_screen.dart';
import 'package:social_app/shared/components/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(
    key: "uId",
  ).then((value) {
    if (value) {
      navigateAndFinish(
        context,
        LoginScreen(),
      );
    }
  });
}

String? uId = CacheHelper.getData(key: "uId");
