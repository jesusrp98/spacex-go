import 'package:flutter/material.dart';
import 'package:row_collection/row_collection.dart';

class RowText extends StatelessWidget {
  final String title, description;

  RowText(this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return RowItem.text(
      title,
      description,
      titleStyle: TextStyle(fontSize: 15),
      descriptionStyle: TextStyle(
        fontSize: 15,
        color: Theme.of(context).textTheme.caption.color,
      ),
    );
  }
}

class RowIcon extends StatelessWidget {
  final String title;
  final bool status;

  RowIcon(this.title, this.status);
  @override
  Widget build(BuildContext context) {
    return RowItem.icon(
      title,
      status,
      size: 18,
      titleStyle: TextStyle(fontSize: 15),
    );
  }
}

class RowDialog extends StatelessWidget {
  final String title;
  final String description;
  final Widget screen;

  RowDialog(this.title, this.description, {this.screen});
  @override
  Widget build(BuildContext context) {
    return RowItem.clickable(
      title,
      description,
      titleStyle: TextStyle(fontSize: 15),
      descriptionStyle: TextStyle(
        fontSize: 15,
        color: Theme.of(context).textTheme.caption.color,
      ),
      onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => screen,
              fullscreenDialog: true,
            ),
          ),
    );
  }
}
