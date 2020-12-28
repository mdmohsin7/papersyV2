import 'package:animations/animations.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/business/unions/extras/extras_union.dart';
import 'package:papersy/business/utils/values.dart';
import 'package:papersy/client/screens/extras/extras_connector.dart';
import 'package:papersy/client/widgets/extras_card.dart';

import '../../../sizeconfig.dart';

class ExtrasWidget extends StatelessWidget {
  const ExtrasWidget();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double _height = SizeConfig.blockSizeVertical;
    double _width = SizeConfig.blockSizeHorizontal;
    return StoreConnector<AppState, EVM>(
      vm: ExtrasVM(),
      builder: (context, evm) {
        return CustomScrollView(
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
                        print("pre3 = ${evm.extrasUnion}");
                        if (evm.extrasUnion is None) {
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
                        } else if (evm.extrasUnion is Loading) {
                          return Column(
                            children: [
                              SizedBox(height: _height * 6),
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          );
                        } else if (evm.extrasUnion is Loaded) {
                          if (index == evm.extrasList.length) {
                            return SizedBox(
                              height: _height * 12,
                            );
                          } else {
                            return ExtrasCard(
                              report: () {
                                evm.report(
                                  "P",
                                  "OU",
                                  evm.extrasList[index].subject,
                                  evm.extrasList[index].uploader,
                                );
                              },
                              preview: () async {
                                // count1++;
                                // myInterstitial.load();
                                // if (count1 % 5 == 0) {
                                //   if (await myInterstitial.isLoaded()) {
                                //     myInterstitial.show();
                                //   }
                                // }
                                // evm.preview((evm.extrasList[index]).download);
                              },
                              download: () async {
                                String sub = (evm.extrasList[index]).subject;
                                String year = (evm.extrasList[index]).units;
                                String link = (evm.extrasList[index]).id != null
                                    ? (evm.extrasList[index]).id
                                    : (evm.extrasList[index]).link;
                                // count1++;
                                // myInterstitial.load();
                                // if (count1 % 3 == 0) {
                                //   if (await myInterstitial.isLoaded()) {
                                //     myInterstitial.show();
                                //   }
                                // }
                                evm.download(sub, year, link);
                              },
                              author: (evm.extrasList[index]).uploader,
                              subject: (evm.extrasList[index]).subject,
                              units: (evm.extrasList[index]).units,
                            );
                          }
                        } else if (evm.extrasUnion is NoInternet) {
                          return Container();
                        } else if (evm.extrasUnion is IsEmpty) {
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
                  // return ExtrasCard(
                  //   author: "test",
                  //   download: () {},
                  //   preview: () {},
                  //   subject: "testing",
                  //   type: "Important Questions",
                  //   units: "1-5",
                  // );
                },
                childCount: 1,
              ),
            ),
          ],
        );
      },
    );
  }
}
