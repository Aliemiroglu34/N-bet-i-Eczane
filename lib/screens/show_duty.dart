import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class ShowDuty extends StatefulWidget {
  late String cityName;
  late String districtName;
  ShowDuty({required this.cityName, required this.districtName});

  @override
  State<ShowDuty> createState() => _ShowDutyState();
}

class _ShowDutyState extends State<ShowDuty> {
  @override
  void initState() {
    super.initState();
  }

  //String apiResult= "";
  Future<String> getxx() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'apikey 2eQsZ1BdYYlcQCPSGehod7:1c6thbOqYX0oPjrbuvqav1'
    };
    var url = Uri.parse(
        "https://api.collectapi.com/health/dutyPharmacy?ilce=${widget.districtName}&il=${widget.cityName}");
    var res = await http.get(url, headers: requestHeaders);
    final body = res.body;
    return body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: FutureBuilder(
            future: getxx(),
            builder: (context, snop) {
              if (snop.hasData) {
                Map<String, dynamic> map = json.decode(snop.data.toString());
                List<dynamic> data = map["result"];

                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        height: 250,
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Card(
                            elevation: 6,
                            child: Row(

                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(child: Text(data[index]["name"] + " Eczanesi")),

                                      Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "Adres :" + data[index]["address"],),
                                          ),),
                                      Expanded(child: Text("Telefon:"+data[index]["phone"]))
                                    ],
                                  ),
                                ),
                                Expanded(flex:1,child: IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.map,color: Colors.green,size: 35,)))
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
