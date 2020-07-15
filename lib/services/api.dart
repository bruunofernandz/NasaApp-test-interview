import 'package:dio/dio.dart';
import 'package:nasa_app/database/db.dart';
import 'package:nasa_app/models/nasa_model.dart';

class Api {
  Dio dio = Dio();
  DatabaseCreator databaseCreator = DatabaseCreator();

  Future getApi() async {
    Response response = await dio.get(
        "https://api.nasa.gov/planetary/apod?api_key=Fty80HkuF2LSDWPVutz34KJ4MXh9JWWKo8degZO4&count=10");

    if (response.statusCode == 200) {
      final List<NasaModel> list = (response.data as List)
          .map((item) => NasaModel.fromJson(item))
          .toList();

      databaseCreator.deleteAll();
      for (var node in list) {
        databaseCreator.insertPhoto(node);
        print(node);
      }
      return list;
    } else {
      return [];
    }
  }
}
