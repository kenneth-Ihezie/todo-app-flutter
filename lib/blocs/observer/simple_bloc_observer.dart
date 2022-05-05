/*
we will implement our own BlocObserver which will allow us
to handle all state changes and errors in a single place.
It's really useful for things like developer logs or analytics.
*/

import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}


/*
All we're doing in this case is printing all state changes (transitions)
and errors to the console just so that we can see what's going
on when we're running our app. You can hook up your BlocObserver
to google analytics, sentry, crashlytics, etc...
*/