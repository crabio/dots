// External
import 'package:dots_client/pages/settings/widget/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';

// Internal
import 'package:dots_client/settings/settings.dart';
import 'bloc/events.dart';
import 'bloc/bloc.dart';
import 'bloc/state.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsPageBloc, SettingsPageState>(
      builder: (context, state) {
        if (state is InitingState) {
          return const CircularProgressIndicator();
        } else if (state is InitedState) {
          return SettingsList(
            sections: [
              SettingsSection(
                title: 'Theme',
                tiles: [
                  SettingsTile.switchTile(
                    title: 'Use OS theme',
                    subtitle: 'Use OS ligth/dark theme setting.',
                    leading: const Icon(Icons.wb_twilight_rounded),
                    onToggle: (value) => context
                        .read<SettingsPageBloc>()
                        .add(ChangeUseOsThemeEvent(value: value)),
                    switchValue: state.settings.useOsThemeSettings,
                  ),
                  SettingsTile.switchTile(
                    title: 'Ligth theme',
                    subtitle: 'Use ligth or dark theme.',
                    leading: const Icon(Icons.wb_sunny_rounded),
                    onToggle: (value) => context
                        .read<SettingsPageBloc>()
                        .add(ChangeLightThemeEvent(
                          context: context,
                          value: value,
                        )),
                    switchValue: state.settings.ligthTheme,
                    enabled: !state.settings.useOsThemeSettings,
                  ),
                ],
              ),
              SettingsSection(
                title: 'Common',
                tiles: [
                  SettingsTile(
                    title: 'Environment',
                    subtitle: state.settings.environment.toShortString(),
                    leading: const Icon(Icons.cloud_queue),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onPressed: (context) async {
                      final index = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EnvironmentPage(),
                        ),
                      );
                      context
                          .read<SettingsPageBloc>()
                          .add(ChangeEnvironmentEvent(index: index));
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: 'Misc',
                tiles: const [
                  SettingsTile(
                    title: 'Terms of Service',
                    leading: Icon(Icons.description),
                    trailing: SizedBox(),
                  ),
                  SettingsTile(
                    title: 'Changelog',
                    leading: Icon(Icons.list),
                    trailing: SizedBox(),
                  ),
                  SettingsTile(
                    title: 'Open source licenses',
                    leading: Icon(Icons.collections_bookmark),
                    trailing: SizedBox(),
                  ),
                ],
              ),
              CustomSection(
                child: Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 22, bottom: 8),
                      child: Icon(Icons.settings),
                    ),
                    Text(
                      'Version: 2.4.0 (287)',
                      style: TextStyle(color: Color(0xFF777777)),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return Text("Unkown state: $state");
      },
    );
  }
}
