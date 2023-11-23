import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
class SkeletonCase extends StatefulWidget {
  const SkeletonCase({super.key, required this.width, required this.height, required this.borderRadius});
  final double width;
  final double height;
  final double borderRadius;

  @override
  State<SkeletonCase> createState() => _SkeletonCaseState();
}

class _SkeletonCaseState extends State<SkeletonCase> {
  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius),
          ),
        ),
      ),
    );
  }
}
