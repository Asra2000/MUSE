import 'package:http/http.dart' as http;
import 'dart:convert';
class NetworkHelper{
  String url;
  NetworkHelper({this.url});

  Future<List> getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      Map decodedData = jsonDecode(data);
      return decodedData['results'];
    } else {
      print(response.statusCode);
    }
  }
  Future<String> getTrack() async{
    http.Response response = await http.get(url);
    if (response.statusCode == 200){
      String data = response.body;
      Map decodedData = jsonDecode(data);
      return decodedData['results'][0]['previewUrl'];
    }
    else
      return "";
  }
  Future getTopRadio()async{
    http.Response response = await http.get(url);
    if (response.statusCode == 200){
      String data = response.body;
      Map decodedData = jsonDecode(data);
      return decodedData;
    }
    else
      return "";
  }
  Future track()async{
    http.Response response = await http.get("http://yp.shoutcast.com/sbin/tunein-station.m3u?id=99476756");
    String data = response.body;
    print(data.substring(data.length-34));
  }
}