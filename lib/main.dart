import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'ui/my_colors.dart';
import 'models/data.dart';

Future main() async {
  await dotenv.load(fileName: '.env');

  runApp(
    ChangeNotifierProvider(
      create: (context) => Data(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galão da massa',
      theme: ThemeData(
        primarySwatch: primaryBlack,
      ),
      home: Galao(),
    );
  }
}

class Galao extends StatefulWidget {
  @override
  State<Galao> createState() => _GalaoState();
}

class _GalaoState extends State<Galao> {
  @override
  Widget build(BuildContext context) {
    Future<void> _reload() async {
      await Future.delayed(const Duration(seconds: 2), () => context.read<Data>().consultData());
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/galo.png',
                fit: BoxFit.contain,
                height: 60,
              ),
              const Text('Galão da massa')
            ],
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Próx. jogos', icon: Icon(Icons.east_outlined)),
              Tab(text: 'Ult. jogos', icon: Icon(Icons.check)),
              Tab(text: 'Brasileirão', icon: Icon(Icons.table_chart))
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: _nextPlayers(context.watch<Data>().res['proximos'], _reload)),
            Center(child: _lastPlayers(context.watch<Data>().res['ultimos'], _reload)),
            Center(child: _table(context.watch<Data>().res['tabela'], _reload)),
          ],
        ),
      )
    );
  }
}

_nextPlayers(np, _reload) {
  _call() {
    _reload();
    return const Center(child: Text('Carregando...'));
  }

  return np['jogos'] != null && np['jogos'].length > 0 ? RefreshIndicator(
    child: ListView.builder(
      itemCount: np['jogos'].length,
      itemBuilder: (_, int index) {
        return Card(
          elevation: 3,
          margin: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: 300,
            height: 130,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 12.0),

                        Image.network(
                          np['jogos'][index]['time1_img'],
                          width: 30.0,
                          height: 30.0,
                          fit: BoxFit.fill
                        ),

                        const SizedBox(height: 15.0),

                        Text(
                          np['jogos'][index]['time1_name'].toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0
                          )
                        )
                      ],
                    ),

                    const SizedBox(width: 50),

                    Text(
                      'X'.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0
                      )
                    ),

                    const SizedBox(width: 50),

                    Column(
                      children: [
                        const SizedBox(height: 12.0),

                        Image.network(
                          np['jogos'][index]['time2_img'],
                          width: 30.0,
                          height: 30.0,
                          fit: BoxFit.fill
                        ),

                        const SizedBox(height: 15.0),

                        Text(
                          np['jogos'][index]['time2_name'].toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0
                          )
                        )
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 18.0),

                Text(np['jogos'][index]['label']),
              ],
            )
          )
        );
      },
    ),
    onRefresh: _reload,
  ) : _call();
}

_lastPlayers(lp, _reload) {
  _call() {
    _reload();
    return const Center(child: Text('Carregando...'));
  }

  return lp['jogos'] != null && lp['jogos'].length > 0 ? RefreshIndicator(
    child: ListView.builder(
      itemCount: lp['jogos'].length,
      itemBuilder: (_, int index) {
        return Card(
          elevation: 3,
          margin: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: 300,
            height: 130,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 12.0),

                        Image.network(
                          lp['jogos'][index]['time1_img'],
                          width: 30.0,
                          height: 30.0,
                          fit: BoxFit.fill
                        ),

                        const SizedBox(height: 15.0),

                        Text(
                          lp['jogos'][index]['time1_name'].toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0
                          )
                        )
                      ],
                    ),

                    const SizedBox(width: 50),

                    Row(
                      children: [
                        Text(
                          lp['jogos'][index]['resultado_time1'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0
                          )
                        ),

                        const SizedBox(width: 15.0),

                        Text(
                          'X'.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0
                          )
                        ),

                        const SizedBox(width: 15.0),

                        Text(
                          lp['jogos'][index]['resultado_time2'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0
                          )
                        ),
                      ],
                    ),

                    const SizedBox(width: 50),

                    Column(
                      children: [
                        const SizedBox(height: 12.0),

                        Image.network(
                          lp['jogos'][index]['time2_img'],
                          width: 30.0,
                          height: 30.0,
                          fit: BoxFit.fill
                        ),

                        const SizedBox(height: 15.0),

                        Text(
                          lp['jogos'][index]['time2_name'].toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0
                          )
                        )
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 18.0),

                Text(lp['jogos'][index]['label']),
              ],
            )
          )
        );
      },
    ),
    onRefresh: _reload,
  ) : _call();
}

_table(tb, _reload) {
  _call() {
    _reload();
    return const Center(child: Text('Carregando...'));
  }

  return tb.length > 0 ? RefreshIndicator(
    child: ListView.builder(
      itemCount: tb.length,
      itemBuilder: (_, int index) {
        return Card(
          elevation: 3,
          margin: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: 300,
            height: 130,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 12.0),

                        Image.network(
                          tb[index]['img'],
                          width: 30.0,
                          height: 30.0,
                          fit: BoxFit.fill
                        ),

                        const SizedBox(height: 15.0),

                        Text(
                          tb[index]['nome'].toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0
                          )
                        )
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 5.0),

                Container(
                  margin: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Posição: ',
                        style: TextStyle(fontWeight: FontWeight.bold)
                      ),

                      Text(tb[index]['posicao']),

                      const SizedBox(width: 40.0),

                      const Text(
                        'Pontos: ',
                        style: TextStyle(fontWeight: FontWeight.bold)
                      ),

                      Text(tb[index]['pontos']),

                      const SizedBox(width: 40.0),

                      const Text(
                        'Jogos: ',
                        style: TextStyle(fontWeight: FontWeight.bold)
                      ),

                      Text(tb[index]['jogos'])
                    ],
                  )
                )
              ],
            )
          )
        );
      },
    ),
    onRefresh: _reload,
  ) : _call();
}
