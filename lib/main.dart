import 'package:a_questionaire/questionnaire_page.dart';
import 'package:a_questionaire/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(textTheme: buildTextTheme(ThemeData.dark().textTheme)),
      home: QuestionnairePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
