import 'package:date_world/interface/repo_interface.dart';

abstract class CategoryRepoInterface extends RepositoryInterface{
  Future<dynamic> getSellerWiseCategoryList(int sellerId);

}