import 'package:animations/animations.dart';
import 'package:async_redux/async_redux.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:papersy/business/core/home/actions/home_action.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/unions/papers/papers_union.dart';
import 'package:papersy/business/utils/values.dart';
import 'package:papersy/client/widgets/papers_card.dart';

import '../../../sizeconfig.dart';
import 'papers_connector.dart';

class Papers extends StatefulWidget {
  const Papers();
  @override
  _PapersState createState() => _PapersState();
}

class _PapersState extends State<Papers> with AutomaticKeepAliveClientMixin {
  InterstitialAd myInterstitial;
  static int count1;
  @override
  void initState() {
    super.initState();
    count1 = 0;
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
          'educational loan'
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
    return StoreConnector<AppState, PVM>(
      vm: PapersVM(widget),
      onInit: (state) => initAction(state, 0),
      builder: (context, pvm) {
        print(pvm.papersList);
        return CustomScrollView(
          key: PageStorageKey<int>(1),
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 350),
                    transitionBuilder: (child, a) {
                      return FadeScaleTransition(
                        child: child,
                        animation: a,
                      );
                    },
                    child: Builder(
                      builder: (context) {
                        print("pre2 = ${pvm.papersUnion}");
                        if (pvm.papersUnion is None) {
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
                        } else if (pvm.papersUnion is Loading) {
                          return Column(
                            children: [
                              SizedBox(height: _height * 6),
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          );
                        } else if (pvm.papersUnion is Loaded) {
                          if (index == pvm.papersList.length) {
                            return SizedBox(
                              height: _height * 12,
                            );
                          } else {
                            return PapersCard(
                              report: () {
                                pvm.report(
                                  "P",
                                  "OU",
                                  pvm.papersList[index].subject,
                                  pvm.papersList[index].uploader,
                                );
                              },
                              preview: () async {
                                count1++;
                                myInterstitial.load();
                                if (count1 % 5 == 0) {
                                  if (await myInterstitial.isLoaded()) {
                                    myInterstitial.show();
                                  }
                                }
                                pvm.preview((pvm.papersList[index]).download);
                              },
                              download: () async {
                                String sub = (pvm.papersList[index]).subject;
                                String year = (pvm.papersList[index]).year;
                                String link = (pvm.papersList[index]).id != null
                                    ? (pvm.papersList[index]).id
                                    : (pvm.papersList[index]).download;
                                count1++;
                                myInterstitial.load();
                                if (count1 % 3 == 0) {
                                  if (await myInterstitial.isLoaded()) {
                                    myInterstitial.show();
                                  }
                                }
                                pvm.download(sub, year, link);
                              },
                              uploader: (pvm.papersList[index]).uploader,
                              subject: (pvm.papersList[index]).subject,
                              year: (pvm.papersList[index]).year,
                              isUpvoted: false,
                              votesCount: 0,
                            );
                          }
                        } else if (pvm.papersUnion is NoInternet) {
                          return Container();
                        } else if (pvm.papersUnion is IsEmpty) {
                          return Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: _height * 15,
                                  width: _width * 20,
                                  child: SvgPicture.asset(
                                    "assets/no_data.svg",
                                  ),
                                ),
                                Text(
                                  "Looks like we don\'t have papers of this branch",
                                ),
                              ],
                            ),
                            height: _height * 35,
                            width: _width * 80,
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  );
                },
                childCount: pvm.papersList == null
                    ? 1
                    : pvm.papersUnion is Loading
                        ? 1
                        : pvm.papersList.isEmpty
                            ? 1
                            : pvm.papersList.length + 1,
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
