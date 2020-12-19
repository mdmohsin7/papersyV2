import 'package:animations/animations.dart';
import 'package:async_redux/async_redux.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:papersy/business/main_state.dart';
import 'package:papersy/client/screens/auth/auth_widget.dart';
import 'package:papersy/client/screens/filter/filter_widget.dart';
import 'package:papersy/client/screens/upload/upload_widget.dart';
import 'package:papersy/sizeconfig.dart';
import 'package:share/share.dart';
import '../../screens/personalized/personalized_widget.dart';
import '../../../business/core/home/actions/home_action.dart';
import'../../../business/utils/values.dart';

import 'home_connector.dart';

class Home extends StatelessWidget {
  const Home();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double _height = SizeConfig.blockSizeVertical;
    double _width = SizeConfig.blockSizeHorizontal;
    print("home");
    print("route ${NavigateAction.getCurrentNavigatorRouteName(context)}");

    return StoreConnector<AppState, HVM>(
      vm: HomeVM(),
      onDispose: (state) => disposeHomeAction(state),
      onInit: (state) => checkAuthentication(state),
      builder: (context, hvm) {
        return Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/logo.svg",
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Switch Theme",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  trailing: Icon(
                    FontAwesomeIcons.moon,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  onTap: () {
                    hvm.switchTheme();
                  },
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "Downloads",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  onTap: () {
                    hvm.navigate("downloads");
                  },
                ),
                ListTile(
                  title: Text(
                    hvm.authStatus != null ? "Profile" : "Login/SignUp",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  onTap: () {
                    hvm.navigate(hvm.authStatus != null ? "profile" : "auth");
                  },
                ),
                if (hvm.authStatus != null)
                  ListTile(
                    title: Text(
                      "Log Out",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    onTap: () {
                      hvm.logOut();
                      Navigator.pop(context);
                    },
                  ),
                Divider(),
                ListTile(
                  title: Text(
                    "Rate Us",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  onTap: () {
                    String url = "https://www.bit.ly/papersy";
                    launch(url);
                  },
                ),
                ListTile(
                  title: Text(
                    "Share",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  onTap: () {
                    Share.share(
                        Values.share);
                  },
                ),
                  ListTile(
                  title: Text(
                    "Feedback",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  onTap: () {
                    String url = "https://forms.gle/GJuyHbL3czbVERro8";
                    launch(url);
                  },
                ),
                ListTile(
                  title: Text(
                    "Get In Touch",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  onTap: () {
                    final Uri _emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'thedumbcoders@gmail.com',
                    );
                    launch(_emailLaunchUri.toString());
                  },
                ),
                ListTile(
                  title: Text(
                    "Privacy Policy",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  onTap: () {
                    String url = "https://sites.google.com/view/papersy";
                    launch(url);
                  },
                ),
              ],
            ),
          ),
          body: const PersonalizedWidget(),
          backgroundColor: Theme.of(context).backgroundColor,
          extendBody: true,
          bottomNavigationBar: Builder(
            builder: (context) {
              return BottomAppBar(
                color: Theme.of(context).primaryColor,
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(_height * 1.3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: _width * 2),
                        child: InkWell(
                          child: Icon(
                            Icons.list,
                            size: _height * 3.6,
                          ),
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                      ),
                      DescribedFeatureOverlay(
                        featureId: "filter",
                        tapTarget: Icon(Icons.filter_list),
                        title: const Text("Personalize"),
                        description: const Text(
                            "Tap on the icon and select your course, branch and semester to personalize your feed."),
                        backgroundColor: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        targetColor: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.only(right: _width * 2),
                          child: InkWell(
                            child: Icon(
                              Icons.filter_list,
                              size: _height * 3.6,
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                isDismissible: false,
                                builder: (context) {
                                  return const FilterWidget();
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                shape: CircularNotchedRectangle(),
              );
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: RepaintBoundary(
            child: OpenCont(
              height: _height,
              width: _width,
              user: hvm.authStatus,
            ),
          ),
        );
      },
    );
  }
}

class OpenCont extends StatelessWidget {
  final double height;
  final double width;
  final User user;

  const OpenCont({Key key, this.height, this.width, this.user})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      openColor: Theme.of(context).accentColor,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(height * 4),
      ),
      closedBuilder: (context, oa) {
        return DescribedFeatureOverlay(
          featureId: "upload",
          tapTarget: const Icon(Icons.add),
          targetColor: Colors.red,
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("Upload Notes/Papers"),
          description: const Text(
              "Tap on the icon, login to your account and start uploading your notes/papers"),
          child: Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            height: height * 7.2,
            width: height * 7.2,
            child: const Center(
              child:  Icon(Icons.add),
            ),
          ),
        );
      },
      closedColor: Theme.of(context).accentColor,
      closedElevation: 1.5,
      transitionDuration: Duration(milliseconds: 600),
      transitionType: ContainerTransitionType.fade,
      openBuilder: (context, ca) {
        return user != null ? const UploadWidget() : const AuthWidget();
      },
    );
  }
}
