
import 'package:date_world/features/address/domain/models/address_model.dart';
import 'package:date_world/features/address/domain/models/label_model.dart';
import 'package:date_world/interface/repo_interface.dart';

abstract class AddressRepoInterface<T> implements RepositoryInterface<AddressModel>{

  List<LabelAsModel> getAddressType();

  Future<dynamic> getDeliveryRestrictedCountryList();

  Future<dynamic> getDeliveryRestrictedZipList();

  Future<dynamic> getDeliveryRestrictedZipBySearch(String zipcode);

  Future<dynamic> getDeliveryRestrictedCountryBySearch(String country);


}