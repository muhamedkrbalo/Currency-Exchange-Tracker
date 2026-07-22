import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../shared/extensions/build_context_theme_ext.dart';
import '../../../../shared/theme/app_radii.dart';

/// Loading placeholder for the rates list.
///
/// Mirrors the layout of [RateTile] (leading avatar, name + unit lines and a
/// trailing change chip) so the transition into real content is seamless. A
/// single [Shimmer] wraps the whole list, giving one continuous highlight
/// sweep across every row instead of each bone animating on its own.
class RatesListSkeleton extends StatelessWidget {
  const RatesListSkeleton({super.key, this.itemCount = 10});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Shimmer.fromColors(
      baseColor: colors.shimmerBase,
      highlightColor: colors.shimmerHighlight,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: context.spacing.sm),
        itemCount: itemCount,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (_, _) => const _RateTileSkeleton(),
      ),
    );
  }
}

class _RateTileSkeleton extends StatelessWidget {
  const _RateTileSkeleton();

  @override
  Widget build(BuildContext context) {
    final spacing = context.spacing;

    return ListTile(
      leading: const _Bone(width: 40, height: 40, radius: AppRadii.radiusFull),
      title: Padding(
        padding: EdgeInsets.only(bottom: spacing.sm),
        child: const _Bone(width: 120, height: 14),
      ),
      subtitle: const _Bone(width: 80, height: 12),
      trailing: const _Bone(
        width: 64,
        height: 28,
        radius: AppRadii.radiusFull,
      ),
    );
  }
}

class _Bone extends StatelessWidget {
  const _Bone({
    required this.width,
    required this.height,
    this.radius = AppRadii.radiusSm,
  });

  final double width;
  final double height;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        // Painted by the enclosing Shimmer's gradient.
        color: context.appColors.shimmerBase,
        borderRadius: radius,
      ),
    );
  }
}
