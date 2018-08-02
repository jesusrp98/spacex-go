import 'package:cherry/classes/dragon_info.dart';
import 'package:cherry/colors.dart';
import 'package:cherry/widgets/card_page.dart';
import 'package:cherry/widgets/head_card_page.dart';
import 'package:cherry/widgets/hero_image.dart';
import 'package:cherry/widgets/row_item.dart';
import 'package:flutter/material.dart';

class DragonPage extends StatelessWidget {
  final DragonInfo dragon;

  DragonPage(this.dragon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dragon details'),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  _DragonCard(dragon),
                  SizedBox(
                    height: 8.0,
                  ),
                  _SpecificationsCard(dragon)
                ],
              ),
            )
          ],
        ));
  }
}

class _DragonCard extends StatelessWidget {
  final DragonInfo dragon;

  _DragonCard(this.dragon);

  @override
  Widget build(BuildContext context) {
    return HeadCardPage(
      head: Row(
        children: <Widget>[
          HeroImage().buildHero(
              context: context,
              size: 116.0,
              url: dragon.getImageUrl,
              tag: dragon.id,
              title: dragon.name),
          Container(width: 24.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  dragon.name,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  dragon.getDescription,
                  style: Theme
                      .of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: secondaryText),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  dragon.status,
                  style: Theme
                      .of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: secondaryText),
                ),
              ],
            ),
          )
        ],
      ),
      details: 'Im a dragon capsule :)',
    );
  }
}

class _SpecificationsCard extends StatelessWidget {
  final DragonInfo dragon;

  _SpecificationsCard(this.dragon);

  @override
  Widget build(BuildContext context) {
    return CardPage(
      title: 'SPECIFICATIONS',
      body: <Widget>[
        RowItem.textRow('Crew', dragon.getCrew),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Launch mass', dragon.getLaunchMass),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Return mass', dragon.getReturnMass),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Height', dragon.getHeight),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Diameter', dragon.getDiameter),
      ],
    );
  }
}
