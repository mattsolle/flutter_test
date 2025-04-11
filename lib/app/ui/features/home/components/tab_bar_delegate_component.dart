import 'package:flutter/material.dart';

import '../../../utils/extensions/app_localization_extension.dart';
import '../../../utils/extensions/context_extension.dart';

class TabBarDelegateComponent extends SliverPersistentHeaderDelegate {
  const TabBarDelegateComponent({required this.onTap});

  final ValueSetter<int> onTap;
  

  @override
  double get maxExtent => 42;

  @override
  double get minExtent => 42;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: 42,
      color: context.colorScheme.surface,
      child: TabBar(
        onTap: onTap,
        tabs: [
          Tab(
            text: context.l10n.allRestaurants,
          ),
          Tab(
            text: context.l10n.myFavorites,
          ),
        ],
      ),
    );
  }
}
