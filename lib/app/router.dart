import 'package:auto_route/auto_route_annotations.dart';
import 'package:starter_app/ui/views/home/home_view.dart';
import 'package:starter_app/ui/views/startup/startup_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: HomeView),
  ],
)
class $Router {}
