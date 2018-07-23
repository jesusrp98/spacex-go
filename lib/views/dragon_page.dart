import 'package:cherry/classes/dragon_info.dart';
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
                    height: 16.0,
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
    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _getHeroImage(dragon.id),
                  Container(width: 24.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          dragon.name,
                          style: TextStyle(
                              fontSize: 26.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          dragon.getDescription,
                          style: TextStyle(fontSize: 17.0),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          dragon.status,
                          style: TextStyle(fontSize: 17.0),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }

  Widget _getHeroImage(String serial) {
    return Container(
      height: 128.0,
      width: 128.0,
      child: Hero(
        tag: serial,
        child: DecoratedBox(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/cherry-3ca39.appspot.com/o/falcon9.jpg?alt=media&token=96b5c764-a2ea-43f0-8766-1761db1749d4'))),
        ),
      ),
    );
  }
}

class _SpecificationsCard extends StatelessWidget {
  final DragonInfo dragon;

  _SpecificationsCard(this.dragon);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'SPECIFICATIONS',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
              ),
            ],
          ),
        ));
  }
}
