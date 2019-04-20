import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../util/url.dart';
import 'dialog_round.dart';
import 'separator.dart';

class PatreonDialog extends StatelessWidget {
  static const List<String> _patreons = [
    'Pierangelo Pancera',
    'Michael Christenson II'
  ];

  @override
  Widget build(BuildContext context) {
    return RoundDialog(
      title: FlutterI18n.translate(context, 'about.patreon.title'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: <Widget>[
              Text(
                FlutterI18n.translate(context, 'about.patreon.body_dialog'),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subhead.copyWith(
                      color: Theme.of(context).textTheme.caption.color,
                    ),
              ),
              Separator.spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.cake,
                    size: 50,
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 30,
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                  Icon(
                    Icons.sentiment_satisfied,
                    size: 50,
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                ],
              ),
              Separator.divider(),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: _patreons
                    .map((patreon) => Column(children: <Widget>[
                          Text(
                            patreon,
                            style: Theme.of(context).textTheme.title.copyWith(
                                  color:
                                      Theme.of(context).textTheme.caption.color,
                                ),
                          ),
                          Separator.spacer()
                        ]))
                    .toList(),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'SEE LATER',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                    OutlineButton(
                      highlightedBorderColor: Theme.of(context).accentColor,
                      borderSide: BorderSide(
                        color: Theme.of(context).textTheme.title.color,
                      ),
                      child: Text('PATREON'),
                      onPressed: () async {
                        Navigator.pop(context, true);

                        await FlutterWebBrowser.openWebPage(
                          url: Url.authorPatreon,
                          androidToolbarColor: Theme.of(context).primaryColor,
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
