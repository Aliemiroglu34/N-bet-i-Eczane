import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pharmacy/models/cities.dart';
import 'package:pharmacy/screens/districts.dart';

class ListCities extends StatefulWidget {
  const ListCities({Key? key}) : super(key: key);

  @override
  State<ListCities> createState() => _ListCitiesState();
}

class _ListCitiesState extends State<ListCities> {
  TextEditingController _controller = TextEditingController();
  List liste = <dynamic>[];
  List seachListe = <dynamic>[];
  Cities? citySeach;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                onChanged: (String? query) {
                  seachListe = liste.where((element) {
                    Cities city = Cities.fromJson(element);
                    var name = city.name.toLowerCase();
                    var input = query?.toLowerCase();
                    bool v= name.contains(input!);
                    print("eklendi");
                    return v;
                  }).toList();
                  setState(() {
                print("seachListe"+seachListe.toString());
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: FutureBuilder(
                      future: DefaultAssetBundle.of(context)
                          .loadString("assets/jsondata/cities.json"),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        print("future");

                        if (snapshot.hasData) {
                          String jsonString = snapshot.data!.toString();
                          liste = jsonDecode(jsonString);
                          return AnimationLimiter(
                              child: ListView.builder(
                                  itemCount: seachListe.length > 0
                                      ? seachListe.length
                                      : liste.length,
                                  itemBuilder: (context, index) {
                                    Cities city = Cities.fromJson(liste[index]);
                                    if (seachListe.isNotEmpty) {
                                      print("if seachListe not empty");
                                      citySeach =
                                          Cities.fromJson(seachListe[index]);
                                    }
                                    return ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListviewDistrict(
                                                        id: citySeach!
                                                                .id
                                                                .isNotEmpty
                                                            ? citySeach!
                                                                .id
                                                            : city.id,
                                                        name: citySeach!
                                                                .name
                                                                .isNotEmpty
                                                            ? citySeach!
                                                                .name
                                                            : city
                                                                .name)));
                                      },
                                      leading: CircleAvatar(
                                        child: Text(
                                          city.name[0].toUpperCase(),

                                        ),
                                      ),
                                      title: Text(citySeach != null
                                          ? citySeach!.name
                                          : city.name),
                                      trailing: Icon(
                                          Icons.keyboard_arrow_right),
                                    );
                                  }));
                        } else {
                          return CircularProgressIndicator();
                        }
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
