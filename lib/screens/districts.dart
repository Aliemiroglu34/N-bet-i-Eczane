import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pharmacy/models/districts.dart';
import 'package:pharmacy/screens/show_duty.dart';
class ListviewDistrict extends StatefulWidget {
  late String id;
  late String name;
  ListviewDistrict({required this.id,required this.name});

  @override
  State<ListviewDistrict> createState() => _ListviewDistrictState();
}

class _ListviewDistrictState extends State<ListviewDistrict> {
 late String districtJson;
 List<Districts>allDistricts=<Districts>[];
 var macthList=<String>[];
  @override
  void initState() {

    super.initState();
  }
  Future<String> getCities()async{
     return await DefaultAssetBundle.of(context).loadString("assets/jsondata/district.json");

  }
  Future<void>ddd()async {
  await  getCities().then((value) {
      List list=jsonDecode(value);
      for( var c in list ){
        Districts district=Districts.fromJson(c);
        allDistricts.add(district);

      }

      for( Districts district in allDistricts){
        if(district.ilceSehirkey==widget.id){
          macthList.add(district.ilceTitle);
        }
      }
      print(macthList.length);
    });
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(

      body: SafeArea(child: Column(
      children: [

        Expanded(child: FutureBuilder(
            future: ddd(),
            builder: (context,snopshot){
              return  AnimationLimiter(child: ListView.builder(
                  itemCount: macthList.length,
                  itemBuilder: (context,index){
                    return AnimationConfiguration.staggeredList(
                        duration: Duration(seconds: 1),
                        position: index, child: SlideAnimation(child: FadeInAnimation(child:ListTile(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute
                          (builder: (context)=>ShowDuty(cityName: widget.name, districtName: macthList[index])));
                      },
                      title: Text(macthList[index]),
                    ),),));

                  }));

        }),),
      ],
    ),),);
  }

  void loadDistrict(String json) {
    List districtList=jsonDecode(json);
    print(districtList.length);

  }


}
