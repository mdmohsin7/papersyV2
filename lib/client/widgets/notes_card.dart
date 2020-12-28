import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:papersy/sizeconfig.dart';
import 'package:share/share.dart';

class NotesCard extends StatelessWidget {
  final String subject;
  final String college;
  final String units;
  final String author;
  final Function download;
  final int votesCount;
  final Function vote;
  final bool isUpvoted;
  final Function preview;
  final Function report;

  const NotesCard(
      {this.votesCount,
      this.vote,
      this.isUpvoted,
      this.subject,
      this.college,
      this.units,
      this.author,
      this.download,
      this.preview,
      this.report});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double _height = SizeConfig.blockSizeVertical;
    double _width = SizeConfig.blockSizeHorizontal;
    return Padding(
      padding: EdgeInsets.all(_height * 2.2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor,
        ),
        height: SizeConfig.blockSizeVertical * 37.6,
        child: Column(
          children: [
            Container(
              height: SizeConfig.blockSizeVertical * 30,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(_height * 1.4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 20,
                          height: SizeConfig.blockSizeVertical * 10,
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: Icon(
                            FontAwesomeIcons.book,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 4,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: SizeConfig.blockSizeHorizontal * 60,
                              child: Text(
                                '$subject',
                                style: const TextStyle(
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '${college ?? ''}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Units',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Container(
                              width: _width * 45,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '$units',
                                style: TextStyle(
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Uploader',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Container(
                              width: _width * 40,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '$author',
                                style: const TextStyle(
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 3,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => preview(),
                          child: Container(
                            margin: EdgeInsets.only(left: 8),
                            width: SizeConfig.blockSizeHorizontal * 32,
                            height: SizeConfig.blockSizeVertical * 5.2,
                            decoration: BoxDecoration(
                              color: Theme.of(context).buttonColor,
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Preview',
                              style: const TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => download(),
                          child: Container(
                            margin: EdgeInsets.only(left: 8),
                            width: SizeConfig.blockSizeHorizontal * 32,
                            height: SizeConfig.blockSizeVertical * 5.2,
                            decoration: BoxDecoration(
                              color: Theme.of(context).buttonColor,
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Download',
                              style: const TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    vote();
                  },
                  icon: isUpvoted
                      ? Icon(Boxicons.bxs_upvote)
                      : Icon(Boxicons.bx_upvote),
                ),
                Text(
                  (votesCount ?? 0).toString(),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline5.color,
                  ),
                ),
                const Icon(Boxicons.bx_downvote),
                const VerticalDivider(
                  width: 3,
                ),
                TextButton(
                    onPressed: () {
                      report();
                    },
                    child: Text("Report",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.headline5.color,
                        ))),
                const VerticalDivider(
                  width: 3,
                ),
                TextButton(
                  onPressed: () {
                    Share.share(
                        'Hey check out this $subject notes in Papersy app https://play.google.com/store/apps/details?id=com.thedumbcoders.papersy');
                  },
                  child: Text(
                    "Share",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline5.color,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
