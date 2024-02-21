import '../../modules/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import '../../shared/components/components.dart';

void signout(context){
  CacheHelper.removeData(key: 'token').then((value) => {
    if(value){
      navigateToAndFinish(context,ShopLoginScreen())
    }
  });
}

void printFullText(String? text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text!).forEach((match) => print(match.group(0)));
}

String token='';