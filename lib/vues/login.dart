import 'dart:core';

import 'package:flutter/material.dart';
import 'package:front_end_flutter/vues/liste.dart';
import 'package:front_end_flutter/vues/registration.dart';
import 'package:front_end_flutter/services/service.dart';

import '../modeles/utilisateur.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Utilisateur utilisateur = Utilisateur(
      username: "user05", email: "user08@pass.sn", password: "user08");
  List<TextEditingController> controllers = List.empty(growable: true);
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page de connexion à l\'application'),
      ),
      body: Center(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: TextEditingController(text: utilisateur.email),
                  decoration: const InputDecoration(
                      labelText: "Adresse Mail", icon: Icon(Icons.email)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Cette valeur ne peut être nulle !!!";
                    }
                  },
                  onSaved: (value) {
                    if (value != null) utilisateur.email = value;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: TextEditingController(text: utilisateur.password),
                  decoration: const InputDecoration(
                      labelText: "Mot de Passe", icon: Icon(Icons.vpn_key)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Cette valeur ne peut être nulle !!!";
                    }
                  },
                  onSaved: (value) {
                    utilisateur.password = value!;
                  },
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      if (Service.token == null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ListeRV()),
                        );
                      }
                    }
                  },
                  color: Colors.deepOrange,
                  textColor: Colors.white,
                  child: const Text("Se connecter"),
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      print(utilisateur.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Registration(
                                  title: 'Connexion',
                                )),
                      );
                    }
                  },
                  color: Colors.deepOrange,
                  textColor: Colors.white,
                  child: const Text("Creer un compte"),
                )
              ],
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
