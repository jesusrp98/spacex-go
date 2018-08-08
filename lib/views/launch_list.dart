import 'package:cherry/classes/launch.dart';
import 'package:cherry/colors.dart';
import 'package:cherry/widgets/hero_image.dart';
import 'package:cherry/views/launch_page.dart';
import 'package:cherry/widgets/list_cell.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

class LaunchList extends StatelessWidget {
  final String url;

  LaunchList(this.url);

  Future<List<Launch>> fetchPost() async {
    final response = await http.get(url);

    List jsonDecoded = json.decode(response.body);
    return jsonDecoded.map((m) => Launch.fromJson(m)).toList();
  }

  Future<Null> _handleRefresh() {
    final Completer<Null> completer = new Completer<Null>();
    new Timer(const Duration(seconds: 2), () => completer.complete(null));
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    if (PageStorage.of(context).readState(context, identifier: ValueKey(url)) ==
        null)
      PageStorage.of(context).writeState(
            context,
            fetchPost(),
            identifier: ValueKey(url),
          );

    return Center(
      child: FutureBuilder<List<Launch>>(
        future: PageStorage.of(context).readState(
              context,
              identifier: ValueKey(url),
            ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              if (!snapshot.hasError) {
                final List<Launch> launches = snapshot.data;
                return Scrollbar(
                  child: RefreshIndicator(
                    backgroundColor: primaryColor,
                    onRefresh: _handleRefresh,
                    child: ListView.builder(
                      key: PageStorageKey(url),
                      itemCount: launches.length,
                      itemBuilder: (context, index) {
                        final Launch launch = launches[index];
                        final VoidCallback onClick = () {
                          Navigator.of(context).push(
                            PageRouteBuilder<Null>(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return AnimatedBuilder(
                                  animation: animation,
                                  builder: (context, child) {
                                    return Opacity(
                                      opacity: const Interval(0.0, 0.75,
                                              curve: Curves.fastOutSlowIn)
                                          .transform(animation.value),
                                      child: LaunchPage(launch),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        };

                        return Column(children: <Widget>[
                          ListCell(
                            leading: HeroImage().buildHero(
                              context: context,
                              url: launch.getImageUrl,
                              tag: launch.getNumber,
                              title: launch.name,
                              onClick: onClick,
                            ),
                            title: launch.name,
                            subtitle: launch.getDate,
                            trailing: MissionNumber(launch.getNumber),
                            onTap: onClick,
                          ),
                          const Divider(height: 0.0, indent: 104.0)
                        ]);
                      },
                    ),
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
