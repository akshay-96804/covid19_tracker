import 'dart:convert';

// import 'package:covid_tracker/data.dart';
import 'package:covid_tracker/database.dart';
import 'package:covid_tracker/piechart.dart';
import 'package:covid_tracker/worldwidepanel.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'countryPage.dart';
import 'infoPanel.dart';
import 'mostAffected.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url = 'https://disease.sh/v3/covid-19/all';

  String countryurl = 'https://corona.lmao.ninja/v2/countries?sort=cases';

  Map worldData;
  List countryData;

  @override
  void initState() {
    super.initState();
    fetchCompleteData();
  }

  fetchData() async {
    http.Response response = await http.get(url);
    setState(() {
      worldData = jsonDecode(response.body);
    });
  }

  fetchCountryData() async {
    http.Response response = await http.get(countryurl);
    setState(() {
      countryData = jsonDecode(response.body);
    });
  }

  Future fetchCompleteData() async {
    await fetchData();
    await fetchCountryData();
  }

  // DataSource dataSource = DataSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID 19 TRACKER'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchCompleteData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                alignment: Alignment.center,
                child: Text(
                  '${DataSource.quote}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.orange[800],
                    fontWeight: FontWeight.w700,
                  ),
                ),
                height: 100.0,
                color: Colors.orange[100],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('WorldWide',
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.bold)),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(25.0)),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CountryPage();
                          }));
                        },
                        child: Text(
                          'Regional',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              worldData == null
                  ? Center(child: CircularProgressIndicator())
                  : WorldWidePanel(
                      worldData: worldData,
                      /*activeCount: worldData['active'].toString(),
                      confirmedCount: worldData['cases'].toString(),
                      deathCount: worldData['deaths'].toString(),
                      recoveredCount: worldData['recovered'].toString(),*/
                    ),
              worldData == null
                  ? Center(child: CircularProgressIndicator())
                  : Piechart(worldData: worldData),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Most Affected Countries',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10.0),
              countryData == null
                  ? Center(child: CircularProgressIndicator())
                  : MostAffectedCountry(myData: countryData),
              SizedBox(height: 10.0),
              InfoPanel()
            ],
          ),
        ),
      ),
    );
  }
}
