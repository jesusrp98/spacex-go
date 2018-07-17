import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../views/details_dialog.dart';

class RowItem extends StatelessWidget {
  final String title;
  final Widget description;

  RowItem({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 17.0),
          ),
          description
        ],
      ),
    );
  }

  factory RowItem.textRow(String title, String description) {
    return RowItem(
      title: title,
      description: _getDescriptionWidget(description),
    );
  }

  factory RowItem.iconRow(String title, bool status) {
    return RowItem(
      title: title,
      description: _getIconWidget(status),
    );
  }

  factory RowItem.dialogRow(BuildContext context, String title,
      String description, DetailsDialog dialog,
      {String serial = ''}) {
    return RowItem(
      title: title,
      description: _getDialogWidget(context, dialog, description),
    );
  }

  static Widget _getIconWidget(bool status) {
    return Icon(
      status == null
          ? Icons.remove_circle
          : (status ? Icons.check_circle : Icons.cancel),
      color: status == null
          ? Colors.blueGrey
          : (status ? Colors.green : Colors.red),
    );
  }

  static Widget _getDescriptionWidget(String description,
      [bool clickable = false]) {
    return Text(
      description,
      style: TextStyle(
          fontSize: 17.0,
          color: Colors.white70,
          decoration:
              clickable ? TextDecoration.underline : TextDecoration.none),
    );
  }

  static _getDialogWidget(
      BuildContext context, DetailsDialog dialog, String description) {
    return InkWell(
      child: _getDescriptionWidget(description, true),
      onTap: () {
        if (description != 'Unknown')
          showDialog(context: context, builder: (context) => dialog);
        else
          Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Error fetching data'),
              ));
      },
    );
  }
}
