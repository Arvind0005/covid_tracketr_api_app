import 'package:flutter/widgets.dart';
import 'package:covid_tracker/enums/screen_type.dart';

class Sizinginfo {
  final Orientation orientation;
  final Screentype deviceScreenType;
  final Size screensize;
  final Size localwidgetsize;

  Sizinginfo(this.orientation, this.deviceScreenType, this.screensize,
      this.localwidgetsize);

  @override
  String tostring() {
    return "orientation: $orientation,deviceScreenType:$deviceScreenType,screensize:$screensize,localwidgetsize:$localwidgetsize";
  }
}
