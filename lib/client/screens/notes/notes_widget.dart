import 'package:animations/animations.dart';
import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:papersy/business/core/home/actions/home_action.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/unions/notes/notes_union.dart';
import 'package:papersy/business/utils/values.dart';
import 'package:papersy/client/screens/notes/notes_connector.dart';
import 'package:papersy/client/widgets/notes_card.dart';
import '../../../sizeconfig.dart';

class Notes extends StatefulWidget {
  const Notes();
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> with AutomaticKeepAliveClientMixin {
  InterstitialAd myInterstitial;
  static int count;
  @override
  void initState() {
    super.initState();
    count = 0;
    myInterstitial = InterstitialAd(
      adUnitId: "ca-app-pub-2155617318975151/7902230811",
      targetingInfo: MobileAdTargetingInfo(
        keywords: <String>[
          'shopping',
          'education',
          'undergraduate',
          'courses',
          'pharmacy',
          'postgraduate',
          'programming',
          'educational loan',
        ],
      ),
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
    myInterstitial.load();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    super.build(context);
    double _height = SizeConfig.blockSizeVertical;
    double _width = SizeConfig.blockSizeHorizontal;
    return StoreConnector<AppState, NVM>(
      vm: NotesVM(widget),
      onInit: (state) => initAction(state, 0),
      builder: (context, nvm) {
        return CustomScrollView(
          key: PageStorageKey<int>(2),
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var ni = index;
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 400),
                    child: Builder(
                      builder: (context) {
                        if (nvm.notesUnion is None) {
                          return Container(
                            height: _height * 20,
                            width: _width * 80,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: _height * 8,
                                ),
                                const Text(
                                  Values.personalize,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: _height * 4,
                                ),
                                const Text(
                                  Values.personalizeHint,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        } else if (nvm.notesUnion is Loading) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: _height * 6),
                              Center(child: CircularProgressIndicator()),
                            ],
                          );
                        } else if (nvm.notesUnion is Loaded) {
                          if (ni == nvm.notesList.length) {
                            return SizedBox(
                              height: _height * 12,
                            );
                          } else {
                            return NotesCard(
                              report: () {
                                nvm.report(nvm.notesList[ni].ref);
                              },
                              download: () async {
                                String sub = (nvm.notesList[ni]).subject;
                                String clg = (nvm.notesList[ni]).college;
                                String link = (nvm.notesList[ni]).id != null
                                    ? (nvm.notesList[ni]).id
                                    : (nvm.notesList[ni]).download;
                                count++;
                                myInterstitial.load();
                                if (count % 3 == 0) {
                                  if (await myInterstitial.isLoaded()) {
                                    myInterstitial.show();
                                  }
                                }
                                nvm.download(sub, clg, link);
                              },
                              preview: () async {
                                count++;
                                myInterstitial.load();
                                if (count % 5 == 0) {
                                  if (await myInterstitial.isLoaded()) {
                                    myInterstitial.show();
                                  }
                                }
                                nvm.preview((nvm.notesList[ni]).download);
                                print(nvm.notesList[ni].download);
                              },
                              author: (nvm.notesList[ni]).author,
                              college: (nvm.notesList[ni]).college,
                              subject: (nvm.notesList[ni]).subject,
                              units: (nvm.notesList[ni]).units,
                              size: nvm.notesList[ni].size,
                            );
                          }
                        } else if (nvm.notesUnion is IsEmpty) {
                          return Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: _height * 15,
                                    width: _width * 20,
                                    child:
                                        SvgPicture.asset("assets/no_data.svg")),
                                const Text(
                                    "Looks like we don\'t have notes of this branch"),
                              ],
                            ),
                            height: _height * 35,
                            width: _width * 80,
                          );
                        } else if (nvm.notesUnion is NoInternet) {
                          return Container();
                        } else {
                          return Container();
                        }
                      },
                    ),
                    transitionBuilder: (child, a) {
                      return FadeScaleTransition(
                        child: child,
                        animation: a,
                      );
                    },
                  );
                },
                childCount: nvm.notesUnion is Loading
                    ? 1
                    : nvm.notesList == null
                        ? 1
                        : nvm.notesList.isEmpty
                            ? 1
                            : nvm.notesList.length + 1,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
