import 'package:get_it/get_it.dart';
import 'package:piano_flutter_plugin/piano_flutter_plugin.dart';
import 'package:pocket_guide/core/constants/environment.dart';

late final PianoFlutterPlugin pianoFlutterPlugin;

class GetItService {
  static void registerAppServices() {
    GetItService().registerPianoAnalyticSDK();
  }

  void registerPianoAnalyticSDK() {
    GetIt.I.registerSingleton<PianoFlutterPlugin>(PianoFlutterPlugin());
    pianoFlutterPlugin = GetIt.I<PianoFlutterPlugin>();
    // config with domain and SiteId
    pianoFlutterPlugin.config(Environment.domain, Environment.sideId);
  }
}
