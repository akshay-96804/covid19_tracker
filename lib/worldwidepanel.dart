import 'package:flutter/material.dart';

class WorldWidePanel extends StatelessWidget {
  Map worldData;

  /*String activeCount;
  String confirmedCount;
  String recoveredCount;
  String deathCount;*/

  WorldWidePanel({
    this.worldData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 2.0),
      children: [
        StatusPanel(
          color: Colors.red[300],
          count: '${worldData['cases']}',
          status: 'Confirmed',
        ),
        StatusPanel(
          color: Colors.blue[200],
          count: '${worldData['active']}',
          status: 'Active',
        ),
        StatusPanel(
          color: Colors.green[200],
          count: '${worldData['recovered']}',
          status: 'Recovered',
        ),
        StatusPanel(
          color: Colors.grey[300],
          count: '${worldData['deaths']}',
          status: 'Deaths',
        ),
      ],
    ));
  }
}

class StatusPanel extends StatelessWidget {
  Color color;
  String count;
  String status;
  StatusPanel({this.color, this.count, this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(5.0),
      color: color,
      height: MediaQuery.of(context).size.width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$count',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('$status', style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
