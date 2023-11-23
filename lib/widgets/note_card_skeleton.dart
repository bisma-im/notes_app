import 'package:flutter/material.dart';
import 'skeleton_case.dart';

Widget noteSkeleton(BuildContext context) => Card(
  color: Theme.of(context).colorScheme.background,
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: SkeletonCase(width: MediaQuery.of(context).size.width *0.4, height: 18, borderRadius: 12),
          trailing: SkeletonCase(width: MediaQuery.of(context).size.width *0.3, height: 18, borderRadius: 12),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SkeletonCase(width: MediaQuery.of(context).size.width, height: 18, borderRadius: 12),
        ),
      ],
    ),
  ),
);