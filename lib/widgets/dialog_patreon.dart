import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../util/url.dart';
import 'dialog_round.dart';
import 'separator.dart';

class PatreonDialog extends StatelessWidget {
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
                FlutterI18n.translate(context, 'about.patreon.body'),
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
                    size: 56,
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 32,
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                  Icon(
                    Icons.sentiment_satisfied,
                    size: 56,
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                ],
              ),
              Separator.spacer(),
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
                          url: Url.patreonPage,
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
