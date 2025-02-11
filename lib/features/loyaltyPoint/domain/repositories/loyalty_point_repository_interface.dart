import 'package:date_world/interface/repo_interface.dart';

abstract class LoyaltyPointRepositoryInterface implements RepositoryInterface{
  Future<dynamic> convertPointToCurrency(int point);
}