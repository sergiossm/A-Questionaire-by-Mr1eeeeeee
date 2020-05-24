import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final FlareControls _controls = FlareControls();
  final _animated, _onNextPressed;

  NextButton({
    bool animated = false,
    @required Function onNextPressed,
  })  : _animated = animated,
        _onNextPressed = onNextPressed;

  @override
  Widget build(BuildContext context) => _animated
      ? Container(
          height: 45,
          width: 155,
          child: GestureDetector(
            onTap: () {
              _controls.play('button_to_check');
            },
            child: FlareActor(
              'assets/button_check.flr',
              controller: _controls,
              sizeFromArtboard: true,
            ),
          ),
        )
      : Container(
          height: 43,
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: EdgeInsets.all(0.0),
            onPressed: _onNextPressed,
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1DD098),
                    Color(0xFF21D7BE),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Container(
                constraints: BoxConstraints(maxWidth: 155.0, maxHeight: 43),
                alignment: Alignment.center,
                child: Text(
                  "Next",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        );
}
