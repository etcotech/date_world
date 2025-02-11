import 'package:date_world/interface/repo_interface.dart';

abstract class FeaturedDealRepositoryInterface implements RepositoryInterface{

  Future<dynamic> getFeaturedDeal();
}