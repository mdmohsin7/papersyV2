import 'package:flutter/material.dart';
import 'package:papersy/client/widgets/extras_card.dart';

class ExtrasWidget extends StatelessWidget {
  const ExtrasWidget();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ExtrasCard(
                author: "test",
                download: () {},
                preview: () {},
                subject: "testing",
                type: "Important Questions",
                units: "1-5",
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
