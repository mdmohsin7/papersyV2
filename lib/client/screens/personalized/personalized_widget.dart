import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:papersy/sizeconfig.dart';
import '../papers/papers_widget.dart';
import '../notes/notes_widget.dart';

class PersonalizedWidget extends StatelessWidget {
  const PersonalizedWidget();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, val) => <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              automaticallyImplyLeading: false,
              collapsedHeight: SizeConfig.blockSizeVertical * 10,
              excludeHeaderSemantics: true,
              pinned: true,
              forceElevated: val,
              expandedHeight: SizeConfig.blockSizeVertical * 32,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle
                ],
                collapseMode: CollapseMode.pin,
                titlePadding: EdgeInsetsDirectional.only(bottom: 70),
                title: Text(
                  "Papersy",
                  style: Theme.of(context).textTheme.headline5,
                ),
                centerTitle: true,
              ),
              bottom: const TabBar(
                labelPadding: EdgeInsets.all(10),
                tabs: [
                 const Text("Notes"),
                  const Text("Papers"),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          children: [
            const Notes(),
            const Papers(),
          ],
        ),
      ),
    );
  }
}
