import 'package:epics/view/provider/theme_provider.dart';
import 'package:epics/view/root_page.dart';
import 'package:epics/view/utils/consts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    final dynamic appDocumentDirectory =
        await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path as String);
  }
  final settings = await Hive.openBox('settings');
  await Hive.openBox('supabase_authentication');
  bool isLightTheme = settings.get('isLightTheme') ?? false;
  isLightTheme = true;
  Supabase.initialize(
      url: SUPABASE_URL,
      anonKey: SUPABASE_ANNON_KEY,
      authCallbackUrlHostname: 'login-callback', // optional
      debug: true // optional
      );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(
        isLightTheme: true,
        context: context,
      ),
      child: AppStart(),
    ),
  );
}

class AppStart extends StatelessWidget {
  const AppStart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return RootPage(
      themeProvider: themeProvider,
    );
  }
}
