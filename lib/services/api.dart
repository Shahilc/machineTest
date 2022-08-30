
import 'package:dio/dio.dart';

class APIService{
  Future getData() async {
    try{
      var response = await Dio().get('https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad');
      // print(response.data);
      return response.data;
    }catch(e){
      print('Error $e');
    }
  }
}