import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ktodo/Providers/Theme.dart';
import 'package:provider/provider.dart';

class MenuIndicator extends StatelessWidget {
  final int activeIndex;
  final int itemCount;
  MenuIndicator(this.activeIndex, this.itemCount);
  Widget bottomShape(BuildContext context, ThemeModel theme) => SvgPicture.asset(
    "assets/indicatorBottom.svg",
    color: theme.primaryColor,
  );
  Widget circle(ThemeModel theme) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: theme.accentColor
      ),
    );
  }

  getOffsetX(double menuWidth, int menuItemCount, double indicatorWidth, int activeIndex) {
    double menuItemWidth = menuWidth / menuItemCount;
    double ratio = (activeIndex + 1) / menuItemCount;
    return menuWidth * ratio - menuItemWidth / 2 - indicatorWidth / 2;
  }
  @override
  Widget build(BuildContext context) {
    ThemeModel theme = Provider.of<ThemeModel>(context);
    return Container(
      clipBehavior: Clip.none,
      height: 15,
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        double menuWidth = constraints.biggest.width;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              top: 5,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Opacity(opacity: 0,
                              child: Container(
                                color: Colors.blue,
                                child: bottomShape(context, theme),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                                double offsetX = getOffsetX(
                                    menuWidth,
                                    itemCount,
                                    constraints.biggest.width,
                                    activeIndex
                                );
                                return Transform.translate(
                                  offset: Offset(offsetX, 0),
                                  child: Container(
                                    child: bottomShape(context, theme),
                                    decoration: BoxDecoration(
                                      color: theme.backgroundColor
                                    ),
                                  ),
                                );
                              },),
                            )
                          ],
                        )
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: 0,
                left: 0,
                child: Stack(
                  children: [
                    Opacity(
                      opacity: 0,
                      child: Column(
                        children: [
                          circle(theme),
                          Opacity(opacity: 0, child: bottomShape(context, theme))
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                        double offsetX = getOffsetX(
                          menuWidth,
                          itemCount,
                          constraints.biggest.width,
                          activeIndex
                        );
                        return Transform.translate(
                          offset: Offset(offsetX, 0),
                          child: Column(
                            children: [
                              circle(theme),
                              Opacity(opacity: 0, child: bottomShape(context, theme))
                            ],
                          ),
                        );
                      }),
                    )
                  ],
                )
            )
          ],
        );
      },),
    );
  }

}