import 'package:geo_app/Client/Interfaces/user_interface.dart';
import 'package:geo_app/Client/Models/Weather/weather_basic_model.dart';
import 'package:geo_app/Client/client.dart';
import 'package:geo_app/Client/client_constants.dart';

class WeatherController with IWeather {
  late Client _client;
  late Map _requestMap;

  WeatherController() {
    _client = Client();
    _requestMap = ClientConstants.paths["weather"];
  }

  @override
  Future<WeatherBasicModel> getWeatherByLatLang({required double lat, required double lang}) async {
    try {
      final response = await _client.getMethod(
        _requestMap["currentWeather"],
      );
      if (response == null) {
        throw Exception("Responded as NULL");
      }
      WeatherBasicModel? weatherBasicModel = WeatherBasicModel.fromJson(response.data);
      if (weatherBasicModel == null) {
        throw Exception("An Error Occured!");
      }
      return weatherBasicModel;
    } catch (e) {
      print("at -> getUsers: $e");
    }
    return WeatherBasicModel();
  }
}