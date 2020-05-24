import 'dart:math';

import 'package:a_questionaire/data.dart';
import 'package:a_questionaire/widgets/next_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionList extends StatelessWidget {
  final padding = 18.0, verticalInset = 18.0;
  final double _currentCardPage;
  final Function _onNextPressed;

  const QuestionList({
    Key key,
    @required double currentCardPage,
    @required Function onNextPressed,
  })  : _currentCardPage = currentCardPage,
        _onNextPressed = onNextPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, contraints) {
        List<Widget> children = [];

        for (var i = 0; i < titles.length; i++) {
          var delta = i - _currentCardPage;
          bool isOnRight = delta > 0;

          var start =
              padding + max(20 - 20 * -delta * (isOnRight ? 18 : 1), 0.0);

          var elevation = MAX_ELEVATION - max(-MAX_ELEVATION * delta, 0.0);
          var opacity = MAX_OPACITY - max(-delta, 0.0);

          children.add(
            Positioned.directional(
              textDirection: TextDirection.ltr,
              top: MediaQuery.of(context).size.height * .45 +
                  verticalInset * max(-delta, 0.0),
              bottom: padding + verticalInset * max(-delta, 0.0),
              start: start,
              child: Opacity(
                opacity: opacity < MIN_OPACITY ? MIN_OPACITY : opacity,
                child: Material(
                  elevation: elevation < 0 ? 0 : elevation,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 70,
                      child: Opacity(
                        opacity: opacity < 0 ? 0 : opacity,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: _nextButton(i == titles.length - 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return Stack(
          fit: StackFit.expand,
          children: children,
        );
      },
    );
  }

  Widget _nextButton(bool animated) => Container(
        key: UniqueKey(),
        margin: EdgeInsets.only(bottom: 8),
        alignment: Alignment.bottomCenter,
        child: NextButton(animated: animated, onNextPressed: _onNextPressed),
      );
}

const double MIN_OPACITY = 0.5;
const double MAX_OPACITY = 1.0;
const double MAX_ELEVATION = 4.0;

enum NextButtonStatus {
  HIDDEN,
  DISABLED,
  ENABLED,
}
