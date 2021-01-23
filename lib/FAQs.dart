import 'package:covid_tracker/database.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FAQs'),
        ),
        body: ListView.builder(
            itemCount: DataSource.questionAnswers.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                title: Text(
                  DataSource.questionAnswers[index]['question'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(DataSource.questionAnswers[index]['answer']),
                  )
                ],
              );
            }));
  }
}
