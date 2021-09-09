import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/settings/settings.dart';
import 'package:flutter_weather/theme/cubit/theme_cubit.dart';
import 'package:flutter_weather/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherPageMacOS extends StatelessWidget {
  const WeatherPageMacOS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherCubit>(
      create: (context) => WeatherCubit(context.read<WeatherRepository>()),
      child: WeatherPageMacOSView(),
    );
  }
}

class WeatherPageMacOSView extends StatefulWidget {
  WeatherPageMacOSView({Key? key}) : super(key: key);

  @override
  _WeatherPageMacOSState createState() => _WeatherPageMacOSState();
}

class _WeatherPageMacOSState extends State<WeatherPageMacOSView> {
  final TextEditingController _textEditingController = TextEditingController();
  String get _text => _textEditingController.text;

  int _selectedIndex = 0;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Weather')),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: const [
              NavigationRailDestination(
                icon: const Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.settings),
                label: Text('Settings'),
              )
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                Column(
                  children: [
                    _searchView(),
                    WeatherPageMacOSBodyView(),
                  ],
                ),
                SettingsPage.widget(context.read<WeatherCubit>())
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchView() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                  labelText: 'City', hintText: 'Szczecin'),
            ),
          ),
        ),
        IconButton(
          key: const Key('searchPage_search_iconButton'),
          icon: const Icon(Icons.search),
          onPressed: () => context.read<WeatherCubit>().fetchWeather(_text),
        ),
      ],
    );
  }
}

class WeatherPageMacOSBodyView extends StatelessWidget {
  const WeatherPageMacOSBodyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: BlocConsumer<WeatherCubit, WeatherState>(
            listener: (context, state) {
              if (state.status.isSuccess) {
                context.read<ThemeCubit>().updateTheme(state.weather);
              }
            },
            builder: (context, state) {
              switch (state.status) {
                case WeatherStatus.initial:
                  return const WeatherEmpty();
                case WeatherStatus.loading:
                  return const WeatherLoading();
                case WeatherStatus.success:
                  return WeatherPopulated(
                    weather: state.weather,
                    units: state.temperatureUnits,
                    onRefresh: () {
                      return context.read<WeatherCubit>().refreshWeather();
                    },
                  );
                case WeatherStatus.failure:
                default:
                  return const WeatherError();
              }
            },
          ),
        ),
      ],
    );
  }
}
