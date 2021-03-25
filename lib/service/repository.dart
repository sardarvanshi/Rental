import 'package:rantal/model/userinfo_model.dart';
import 'package:rantal/service/firebsefetch.dart';


class Repository {

  dataprovider DataProvider = dataprovider();

  userinfo fetchdata1() => DataProvider.fetchUserdata();
}
