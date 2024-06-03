import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/internet_bloc.dart';
import 'constant/internet.dart';
import 'cubit/counter_cubit.dart';
import 'cubit/counter_state.dart';
import 'repository/connectivity_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ConnectivityRepository>(
              create: (context) => ConnectivityRepository())
        ],
        child: MultiBlocProvider(
          providers: [
            // RepositoryProvider(create: (context) => ConnectivityRepository()),
            BlocProvider(
              create: (context) => InternetBloc(
                  connectivityRepository:
                      RepositoryProvider.of<ConnectivityRepository>(context)),
            ),
            BlocProvider(
              create: (context) => CounterCubit(
                  connectivityRepository:
                      RepositoryProvider.of<ConnectivityRepository>(context)),
            ),
          ],
          child: const MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetBloc, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == NetworkType.wifi) {
                  return const Text('Wifi Internet Connected');
                } else if (state is InternetConnected &&
                    state.connectionType == NetworkType.mobile) {
                  return const Text('Mobile Internet Connected');
                } else if (state is InternetDisconnected) {
                  return const Text('Internet Disconnected');
                }
                return Container();
              },
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.counterValue == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('WooHoo! You reached zero!'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }
                if (state.counterValue % 5 == 0 && state.counterValue != 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Yay! You reached a multiple of 5!'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Text(
                  '${state.counterValue}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().increment(),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => context.read<CounterCubit>().decrement(),
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
