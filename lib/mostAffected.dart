import 'package:flutter/material.dart';

class MostAffectedCountry extends StatelessWidget {
  String imgUrl = '';
  String countryName = '';
  String deathNumber = '';

  List myData;

  MostAffectedCountry({this.myData});

  @override
  Widget build(BuildContext context) {
    return myData == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return myData == null
                  ? CircularProgressIndicator()
                  : Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Row(
                        children: [
                          Image.network(
                              myData[index]['countryInfo']['flag'].toString(),
                              height: 30),
                          SizedBox(width: 10.0),
                          Text(
                            myData[index]['country'].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10.0),
                          Text('Deaths: ' + myData[index]['deaths'].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red))
                        ],
                      ),
                    );
            },
            itemCount: 5,
          );
  }
}
