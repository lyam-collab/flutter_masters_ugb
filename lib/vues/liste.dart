import 'package:flutter/material.dart';
import 'package:front_end_flutter/services/service.dart';

import '../modeles/rendezvous.dart';

class ListeRV extends StatefulWidget {
  const ListeRV({Key? key}) : super(key: key);

  @override
  _ListeRVState createState() => _ListeRVState();
}

class _ListeRVState extends State<ListeRV> {
  late Future<List<RendezVous>> futureRVs;
  Service service = Service();
  @override
  void initState() {
    super.initState();
    futureRVs = service.getRvs();
  }

  @override
  Widget build(BuildContext context) {
    futureRVs = service.getRvs();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des Rendez-Vous"),
      ),
      body: FutureBuilder<List<RendezVous>>(
        future: futureRVs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.amberAccent,
                  radius: 30,
                  child: Text(snapshot.data![index].lieu[0].toUpperCase()),
                ),
                title: Text(
                  "${snapshot.data![index].lieu}, le  ${snapshot.data![index].date}",
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(snapshot.data![index].description),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: IconButton(
                          onPressed: () {
                            print(
                                "Vous voulez supprimer ${snapshot.data![index]}");
                            setState(() {
                              service.deleteRvs(snapshot.data![index].idRV);
                            });
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.deepOrange,
                          )),
                    ),
                    const Spacer(),
                    Expanded(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.deepOrange,
                          )),
                    )
                  ],
                ),
              ),
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  thickness: 10,
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
