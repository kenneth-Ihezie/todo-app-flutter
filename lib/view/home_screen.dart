/*
Our HomeScreen will be responsible for creating the
Scaffold of our application. It will maintain the AppBar,
BottomNavigationBar, as well as the Stats/FilteredTodos widgets
(depending on the active tab).
 */

import 'package:flutter/material.dart';
import 'package:todo_app/blocs/tab_bloc.dart';
import 'package:todo_app/blocs/todos/events/tab/tab_event.dart';
import 'package:todo_app/blocs/todos/model/tab/app_tab.dart';
import 'package:todo_app/widgets/extra_action_widget.dart';
import 'package:todo_app/widgets/filter_button.dart';
import 'package:todo_app/widgets/filtered_todos.dart';
import 'package:todo_app/widgets/stats.dart';
import 'package:todo_app/widgets/tab_selector.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../localization.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(FlutterBlocLocalizations.of(context).appTitle),
            actions: [
              FilterButton(visible: activeTab == AppTab.TODOS),
              ExtraActions(),
            ],
          ),
          body: activeTab == AppTab.TODOS ? FilteredTodos() : Stats(),
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.addTodoFab,
            onPressed: () {
              Navigator.pushNamed(context, ArchSampleRoutes.addTodo);
            },
            child: Icon(Icons.add),
            tooltip: ArchSampleLocalizations.of(context).addTodo,
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)),
          ),
        );
      },
    );
  }
}
