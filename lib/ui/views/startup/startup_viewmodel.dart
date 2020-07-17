import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:starter_app/app/locator.dart';
import 'package:starter_app/app/router.gr.dart';
import 'package:starter_app/ui/views/home/home_view.dart';

class StartupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void initialize() async {
    await Future.delayed(Duration(seconds: 3));
    _navigationService.replaceWithTransition(HomeView(),
        transition: NavigationTransition.Fade);
  }
}
