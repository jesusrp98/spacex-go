import 'package:cherry/classes/capsule_info.dart';
import 'package:cherry/colors.dart';
import 'package:cherry/widgets/card_page.dart';
import 'package:cherry/widgets/head_card_page.dart';
import 'package:cherry/widgets/hero_image.dart';
import 'package:cherry/widgets/row_item.dart';
import 'package:flutter/material.dart';

// FILE NOT IN USE

class CapsulePage extends StatelessWidget {
  final CapsuleInfo capsule;

  CapsulePage(this.capsule);

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
                  _DragonCard(capsule),
                  SizedBox(
                    height: 8.0,
                  ),
                  _SpecificationsCard(capsule)
                ],
              ),
            )
          ],
        ));
  }
}

class _DragonCard extends StatelessWidget {
  final CapsuleInfo capsule;

  _DragonCard(this.capsule);

  @override
  Widget build(BuildContext context) {
    return HeadCardPage(
      head: Row(
        children: <Widget>[
          HeroImage().buildHero(
              context: context,
              size: 116.0,
              url: capsule.getImageUrl,
              tag: capsule.id,
              title: capsule.name),
          Container(width: 24.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  capsule.name,
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
                  capsule.getDescription,
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
                  capsule.status,
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
  final CapsuleInfo capsule;

  _SpecificationsCard(this.capsule);

  @override
  Widget build(BuildContext context) {
    return CardPage(
      title: 'SPECIFICATIONS',
      body: <Widget>[
        RowItem.textRow('Crew', capsule.getCrew),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Launch mass', capsule.getLaunchMass),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Return mass', capsule.getReturnMass),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Height', capsule.getHeight),
        SizedBox(
          height: 12.0,
        ),
        RowItem.textRow('Diameter', capsule.getDiameter),
      ],
    );
  }
}
