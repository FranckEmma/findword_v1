import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../view/consts.dart';
import '../../view/widgets/letters_grid.dart';
import 'word_bloc.dart';
import 'word_event.dart';
import 'word_state.dart';

class WordGame extends StatelessWidget {
  const WordGame({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:secondaryColor,
      appBar: AppBar(title: const Text('Game Word')),
      body: const LettersGrid() ,);
  }
 //Builder(builder: (context) => BlocProvider( create: (BuildContext context) => WordBloc()..add(InitEvent()),
  Widget _buildPage(BuildContext context) {
    //final bloc = BlocProvider.of<WordBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(children: [
              BlocBuilder<WordBloc, WordState>(builder: (context, state) {
              print(state);
              return TextField(
                  obscureText:( state).isOn,
                  onChanged:  (value) {
                    context.read<WordBloc>().add(GetWordDescription(value));
                  },
                  decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon:  FaIcon((state).isOn? FontAwesomeIcons.eye: FontAwesomeIcons.eyeSlash ),
                        onPressed: () {
                          return context.read<WordBloc>().add(SubmitEvent());
                        },
                      )));
            }), const SizedBox(height: 15,),
            BlocBuilder<WordBloc,WordState>(builder: (context, state) {
              return Text('Vous avez saisir :{state.value}');
            },)],)

           ),
      ],
    );
  }
}
