import 'package:flutter/material.dart';
import 'package:myselff/app/core/extensions/object_extensions.dart';

class TypedListView<T> extends StatelessWidget {
  const TypedListView({
    super.key,
    this.padding,
    this.shrinkWrap,
    this.physics,
    this.controller,
    required this.items,
    required this.itemBuilder,
    this.separatorBuilder,
  });

  final EdgeInsetsGeometry? padding;
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final Iterable<T> items;
  final Widget Function(T item) itemBuilder;
  final Widget Function()? separatorBuilder;

  @override
  Widget build(BuildContext context) {
    return this.separatorBuilder?.let((it) => ListView.separated(
              physics: this.physics,
              shrinkWrap: this.shrinkWrap ?? true,
              padding: this.padding,
              controller: this.controller,
              itemCount: this.items.length,
              itemBuilder: (_, index) =>
                  this.itemBuilder(this.items.elementAt(index)),
              separatorBuilder: (_, __) => it(),
            )) ??
        ListView.builder(
          physics: this.physics,
          shrinkWrap: this.shrinkWrap ?? true,
          padding: this.padding,
          controller: this.controller,
          itemCount: this.items.length,
          itemBuilder: (context, index) =>
              this.itemBuilder(this.items.elementAt(index)),
        );
  }
}
