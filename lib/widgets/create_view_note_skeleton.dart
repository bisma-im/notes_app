import 'package:flutter/material.dart';
import 'skeleton_case.dart';

Widget NoteSkeleton(BuildContext context) => Padding(
  padding: const EdgeInsets.all(10.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SkeletonCase(width: 70, height: 28, borderRadius: 12),
      const SizedBox(height: 16),
      SkeletonCase(width: MediaQuery.of(context).size.width, height: 18, borderRadius: 12),
      const SizedBox(height: 16),
      SkeletonCase(width: MediaQuery.of(context).size.width, height: 18, borderRadius: 12),
    ],
  ),
);
