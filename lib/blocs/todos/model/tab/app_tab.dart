/*
The TabBloc will be responsible for maintaining the
state of the tabs in our application. It will be taking
TabEvents as input and outputting AppTabs.

We need to define an AppTab model which we will also
use to represent the TabState. The AppTab will just
be an enum which represents the active tab in our application.
Since the app we're building will only have two tabs: todos
and stats, we just need two values.
*/

enum AppTab{ TODOS, STATS }