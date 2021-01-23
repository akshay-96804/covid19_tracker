import 'dart:convert';
// import 'package:covid_tracker/data.dart';
import 'package:covid_tracker/search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List countryData;
  String countryUrl = 'https://corona.lmao.ninja/v2/countries?sort=cases';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCountryData();
  }

  fetchCountryData() async {
    http.Response response = await http.get(countryUrl);
    setState(() {
      countryData = jsonDecode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: Search(countryData));
              })
        ],
        title: Text(
          'COUNTRY STATS',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: countryData == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: countryData != null ? countryData.length : null,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  height: 130.0,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey[100],
                        blurRadius: 10.0,
                        offset: Offset(0, 10))
                  ]),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              countryData[index]['country'],
                              style: TextStyle(color: Colors.black),
                            ),
                            Image.network(
                                countryData[index]['countryInfo']['flag'],
                                height: 50.0,
                                width: 60.0)
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'CONFIRMED   ' +
                                    countryData[index]['cases'].toString(),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  'ACTIVE    ' +
                                      countryData[index]['active'].toString(),
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  'RECOVERED    ' +
                                      countryData[index]['recovered']
                                          .toString(),
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  'DEATHS    ' +
                                      countryData[index]['deaths'].toString(),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
    );
  }
}
