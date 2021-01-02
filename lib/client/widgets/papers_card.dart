import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:papersy/sizeconfig.dart';
import 'package:share/share.dart';

class PapersCard extends StatelessWidget {
  final String subject;
  final String year;
  final String uploader;
  final VoidCallback download;
  final Function preview;
  final Function report;
  final String size;

  const PapersCard(
      {this.subject,
      this.year,
      this.download,
      this.uploader,
      this.size,
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
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
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
                padding: const EdgeInsets.all(8.0),
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
                                style: TextStyle(
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                'OU',
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
                              'Year',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Container(
                              width: _width * 45,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '$year',
                                style: TextStyle(
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: _width * 2,
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
                              width: _width * 35,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '$uploader',
                                style: TextStyle(
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
                              style: TextStyle(
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
                              style: TextStyle(
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
                SizedBox(
                  width: _width * 1.8,
                ),
                Text(
                  size == null ? "unavailable" : filesize(size),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline5.color,
                  ),
                ),
                VerticalDivider(
                  width: _width * 2.6,
                ),
                TextButton(
                  onPressed: () {
                    report();
                  },
                  child: Text(
                    "Report",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline5.color,
                    ),
                  ),
                ),
                VerticalDivider(
                  width: 3,
                ),
                TextButton(
                  onPressed: () {
                    Share.share(
                      'Hey check out this $subject question papers in Papersy app https://play.google.com/store/apps/details?id=com.thedumbcoders.papersy',
                    );
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
