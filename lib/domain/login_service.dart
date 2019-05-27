import 'dart:convert' as convert;
import 'package:flutter_movies_up_25/domain/response.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<Response> login(String login, String senha) async {
    var url = "http://livrowebservices.com.br/rest/login";

    print(url);

    final params = {"login": login, "senha": senha};

    final response = await http.post(url, body: params);

    final json = response.body;
    print(json);

    final map = convert.json.decode(json);

    String status = map["status"];
    String msg = map["msg"];

    bool ok = "OK" == status;

    print("Status $status");
    print("Mensagem: $msg");

    return Response(ok, msg: msg);
  }
}