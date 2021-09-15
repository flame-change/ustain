
import 'package:aroundus_app/support/networks/api_result.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';
import 'package:aroundus_app/support/networks/network_exceptions.dart';

class ProductRepository {
  ProductRepository(this._dioClient);
  final DioClient _dioClient;
  
}