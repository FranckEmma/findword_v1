
import 'package:findword_v1/view/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'model/timer/timer_word/timer_word_bloc.dart';
import 'model/word/word_bloc.dart';
import 'model/word/word_event.dart';
import 'model/word/word_view.dart';
import 'model/word_repository.dart';

void main() {
  runApp(
      RepositoryProvider (
          create: (context) => WordRepository.instance,
          child:  const MyApp()),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider( providers:
        [
          BlocProvider<WordBloc>(create: (context) => WordBloc(context.read<WordRepository>())) ,
          BlocProvider<TimerWordBloc>(create: (context) => TimerWordBloc())
        ],

      child: MaterialApp(
        title: 'FindWord',
        theme: ThemeData(
          appBarTheme: AppBarTheme.of(context),
        //  primarySwatch: Colors.green,
        ),
        home:  const MyHomePage(title: 'Find Word'),
        debugShowCheckedModeBanner: false,
        //const MyHomePage( title: 'Find Word',),
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
        backgroundColor:secondaryColor,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  context.read<WordBloc>().add(GenerateLetters());
                 // context.read<TimerWordBloc>().add(StartTimer());

                  Navigator.push(context,MaterialPageRoute(
                          builder: (context) => const WordGame(),
                      ),);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  /* minimumSize: MaterialStateProperty.all(Size(130, 40)),*/
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),),
                child: const Text("Commencer une partie"),
              )  ],

          ),
        ));
  }


}
