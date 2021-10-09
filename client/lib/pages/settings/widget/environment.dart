// External
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

// Internal
import 'package:dots_client/settings/settings.dart';

class EnvironmentPage extends StatelessWidget {
  const EnvironmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Environment')),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: _createEnvList(),
          ),
        ],
      ),
    );
  }

  List<SettingsTile> _createEnvList() {
    final envList = <SettingsTile>[];

    for (final envType in EnvironmentType.values) {
      final env = envType.toEnvironment();
      envList.add(
        SettingsTile(
          title: env.name,
          subtitle: env.host,
          trailing: const Icon(Icons.arrow_forward_ios),
          onPressed: (BuildContext context) {
            Navigator.pop(context, envType.index);
          },
        ),
      );
    }
    return envList;
  }
}
