import 'package:cherry/classes/launch.dart';
import 'package:cherry/colors.dart';
import 'package:cherry/widgets/hero_image.dart';
import 'package:cherry/views/launch_page.dart';
import 'package:cherry/widgets/list_cell.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

/// LAUNCH LIST CLASS
/// Displays a list made out of launches, downloading them using the url.
/// Uses a ListCell item for each launch.
class LaunchList extends StatefulWidget {
  final String _url;

  LaunchList(this._url);

  @override
  State<StatefulWidget> createState() => _LaunchListState();
}

class _LaunchListState extends State<LaunchList> {
  List<Launch> launches;

  /// Handles widget init state
  @override
  void initState() {
    super.initState();
    this.fetchPost();
  }

  /// Downloads the list of launches
  Future fetchPost() async {
    final response = await http.get(widget._url);

    List jsonDecoded = json.decode(response.body);

    this.setState(() {
      launches = jsonDecoded.map((m) => Launch.fromJson(m)).toList();
    });
  }

  /// Handles pull to refresh action
  // TODO fix syncing
  Future<Null> _handleRefresh() async {
    setState(() {
      this.fetchPost();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: (launches == null)
          ? const CircularProgressIndicator()
          : Scrollbar(
              child: RefreshIndicator(
                backgroundColor: primaryColor,
                onRefresh: _handleRefresh,
                child: ListView.builder(
                  key: PageStorageKey(widget._url),
                  itemCount: launches.length,
                  itemBuilder: (context, index) {
                    // Final vars used to display a launch
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

                    // Displays the launch with a ListCell item
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
                        subtitle: launch.getLaunchDate,
                        trailing: MissionNumber(launch.getNumber),
                        onTap: onClick,
                      ),
                      const Divider(height: 0.0, indent: 104.0)
                    ]);
                  },
                ),
              ),
            ),
    );
  }
}
