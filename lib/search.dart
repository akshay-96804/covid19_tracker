import 'package:flutter/material.dart';


class Search extends SearchDelegate {
  final List countryList;

  Search(this.countryList);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(primaryColor: Colors.white);
    // brightness: DynamicTheme.of(context).brightness);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List suggestionList = query.isEmpty
        ? countryList
        : countryList
            .where((element) =>
                element['country'].toString().toLowerCase().startsWith(query))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                      suggestionList[index]['country'],
                      style: TextStyle(color: Colors.black),
                    ),
                    Image.network(suggestionList[index]['countryInfo']['flag'],
                        height: 50.0, width: 60.0)
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
                            suggestionList[index]['cases'].toString(),
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      Text(
                          'ACTIVE    ' +
                              suggestionList[index]['active'].toString(),
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold)),
                      Text(
                          'RECOVERED    ' +
                              suggestionList[index]['recovered'].toString(),
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold)),
                      Text(
                          'DEATHS    ' +
                              suggestionList[index]['deaths'].toString(),
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      itemCount: suggestionList.length,
    );
  }
}
