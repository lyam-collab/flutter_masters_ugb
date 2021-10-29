import 'package:flutter/material.dart';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:front_end_flutter/services/service.dart';
import 'login.dart';
import '../modeles/utilisateur.dart';

class Registration extends StatefulWidget {
  Registration({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  Utilisateur utilisateur = Utilisateur(
      username: "user05", email: "pass@pass.sn", password: "passer123");
  List<TextEditingController> controllers = List.empty(growable: true);
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                  controller: TextEditingController(text: utilisateur.username),
                  decoration: const InputDecoration(
                      labelText: "Nom Utilisateur", icon: Icon(Icons.person)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Cette valeur ne peut être nulle !!!";
                    }
                  },
                  onSaved: (value) {
                    utilisateur.username = value!;
                  },
                ),
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
                      print(utilisateur.toString());
                      Service service = Service();
                      service.ajouterUtilisateur(utilisateur);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    }
                  },
                  color: Colors.deepOrange,
                  textColor: Colors.white,
                  child: const Text("Ajouter Utilisateur"),
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
