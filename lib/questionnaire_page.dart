import 'package:a_questionaire/data.dart';
import 'package:a_questionaire/models/questionnaire_model.dart';
import 'package:a_questionaire/widgets/question_list.dart';
import 'package:a_questionaire/widgets/title_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

TextTheme _textTheme;
QuestionnaireModel _model;

class QuestionnairePage extends StatelessWidget {
  final _cardController = PageController(),
      _titlesController = PageController();

  @override
  Widget build(BuildContext context) {
    _listenToPageChanges();
    _textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0xFF1DD098),
              Color(0xFF21D7BE),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            tileMode: TileMode.clamp),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text('Questionaire'),
          textTheme: Theme.of(context).textTheme,
        ),
        body: ChangeNotifierProvider(
          create: (context) {
            _model = QuestionnaireModel();
            return _model;
          },
          child: Stack(
            children: <Widget>[
              Consumer<QuestionnaireModel>(
                builder: (_, model, __) =>
                    _count(model.currentCardPage.truncate() + 1),
              ),

              // Titles
              Positioned.fill(
                child: PageView.builder(
                  reverse: true,
                  itemCount: titles.length,
                  controller: _titlesController,
                  itemBuilder: (context, index) => Container(),
                  scrollDirection: Axis.vertical,
                ),
              ),
              Consumer<QuestionnaireModel>(
                builder: (_, model, __) => TitleList(
                  currentPage: model.currentTitlePage,
                  titles: titles,
                ),
              ),

              // Cards
              Positioned.fill(
                child: PageView.builder(
                  itemCount: titles.length,
                  controller: _cardController,
                  itemBuilder: (context, index) => Container(),
                ),
              ),
              Consumer<QuestionnaireModel>(
                builder: (_, model, __) => QuestionList(
                  onNextPressed: () {
                    _cardController.animateToPage(
                      _cardController.page.truncate() + 1,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                    _titlesController.animateToPage(
                      _titlesController.page.truncate() + 1,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                  currentCardPage: _cardController.page ?? 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _count(int index) => Positioned.directional(
        start: 32,
        textDirection: TextDirection.ltr,
        top: 8.0,
        child: Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text(
              '$index',
              style: _textTheme.headline4,
            ),
            Text(
              ' /${titles.length}',
              style: _textTheme.headline6,
            ),
          ],
        ),
      );

  void _listenToPageChanges() {
    _cardController.addListener(() {
      _model.setCurrentPage(_cardController.page);
    });
    _titlesController.addListener(() {
      _model.setCurrentPage(_titlesController.page, card: false);
    });
  }
}
