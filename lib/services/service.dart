import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modeles/rendezvous.dart';
import '../modeles/utilisateur.dart';

class Service {
  static var token = "";
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=utf-8",
    'Accept': 'application/json',
  };
  List donnees = List.empty(growable: true);

  Future<List<RendezVous>> getRvs() async {
    final response = await http
        .get(Uri.parse('https://arcane-earth-34008.herokuapp.com/rvs'));
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<RendezVous>((json) => RendezVous.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  addRvs(RendezVous rv) async {
    var url = Uri.parse('https://arcane-earth-34008.herokuapp.com/rvs');
    var jsonEncode2 = jsonEncode({
      "description": rv.description,
      "lieu": rv.lieu,
      "date": DateTime.now().toString().substring(0, 10)
    });
    var response = await http.post(url, headers: headers, body: jsonEncode2);
    print(response.body);
  }

  deleteRvs(id) async {
    var url = Uri.parse('https://arcane-earth-34008.herokuapp.com/rvs/$id');
    var response = await http.delete(url, headers: headers);
    print(response.body);
  }

  ajouterUtilisateur(Utilisateur user) async {
    var url = Uri.parse('https://arcane-earth-34008.herokuapp.com/users');
    var response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          "username": user.username,
          "email": user.email,
          "password": user.password,
          "confirmed": true,
          "blocked": false,
          "role": 1
        }));
    print(response.body);
  }

  authentification(Utilisateur user) async {
    var url = Uri.parse('https://arcane-earth-34008.herokuapp.com/auth/local');
    http.Response response = await http.post(url,
        // headers: headers,
        body: {"identifier": user.email, "password": user.password});
    final responseData = jsonDecode(response.body);
    if (responseData["statusCode"] == null) {
      token = "Bearer ${responseData["jwt"]}";
      return "ok";
    } else {
      return "ko";
    }
  }
}
