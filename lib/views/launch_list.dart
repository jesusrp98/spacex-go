import 'package:cherry/classes/launch.dart';
import 'package:cherry/widgets/hero_image.dart';
import 'package:cherry/views/launch_page.dart';
import 'package:cherry/widgets/list_cell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import 'package:cherry/colors.dart';

class LaunchList extends StatelessWidget {
  final String url;

  LaunchList(this.url);

  Future<List<Launch>> fetchPost(BuildContext context) async {
    final response = await http.get(url);

    List jsonDecoded = json.decode(response.body);
    return jsonDecoded.map((m) => Launch.fromJson(m)).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (PageStorage.of(context).readState(context, identifier: ValueKey(url)) ==
        null)
      PageStorage
          .of(context)
          .writeState(context, fetchPost(context), identifier: ValueKey(url));

    return Center(
      child: FutureBuilder<List<Launch>>(
        future: PageStorage
            .of(context)
            .readState(context, identifier: ValueKey(url)),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (!snapshot.hasError) {
                final List<Launch> launches = snapshot.data;
                return Scrollbar(
                  child: ListView.builder(
                    key: PageStorageKey(url),
                    itemCount: launches.length,
                    itemBuilder: (context, index) {
                      final Launch launch = launches[index];
                      return Column(
                        children: <Widget>[
                          ListCell(
                            image: HeroImage(
                                size: 72.0,
                                url: launch.getImageUrl,
                                tag: launch.getMissionNumber,
                                name: launch.missionName),
                            title: launch.missionName,
                            subtitle: launch.getDate,
                            lateralWidget:
                                MissionNumber(launch.getMissionNumber),
                            onClick: () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => LaunchPage(launch))),
                          ),
                          const Divider(
                            height: 0.0,
                            indent: 104.0,
                          )
                        ],
                      );
                    },
                  ),
                );
              } else
                return const Text("Couldn't connect to server...");
          }
        },
      ),
    );
  }
}
