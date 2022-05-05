/*
This file will contain keys which will use to uniquely identify important
widgets. we can later write test that find widgets based on keys.
We will reference this keys throughout this project.
 */

import 'package:flutter/widgets.dart';

class FlutterTodosKeys {
  static final extraActionsPopupMenuButton =
  const Key('__extraActionsPopupMenuButton__');
  static final extraActionsEmptyContainer =
  const Key('__extraActionsEmptyContainer__');
  static final filteredTodosEmptyContainer =
  const Key('__filteredTodosEmptyContainer__');
  static final statsLoadInProgressIndicator = const Key('__statsLoadInProgressIndicator__');
  static final emptyStatsContainer = const Key('__emptyStatsContainer__');
  static final emptyDetailsContainer = const Key('__emptyDetailsContainer__');
  static final detailsScreenCheckBox = const Key('__detailsScreenCheckBox__');
}

