import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../model/word/word_bloc.dart';
import '../../model/word/word_event.dart';
import '../../model/word/word_state.dart';
import '../consts.dart';

class LettersGrid extends StatefulWidget {
  const LettersGrid({super.key});

  @override
  State<StatefulWidget> createState() => _LettersGridState();
}

class _LettersGridState extends State<LettersGrid> {

  final CountDownController _controller = CountDownController();
  final int _secondsRemaining = 120;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(children: [
            const SizedBox(
            width: 20,
          ),
            const Text("Trouver les mots en anglais !",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                )),
            const SizedBox(
              width: 50,
            ),
            CircularCountDownTimer(
                key: UniqueKey(),
                duration: _secondsRemaining,
                initialDuration: 0,
                width: 60,
                height: 60,
                ringColor: Colors.grey[300]!,
                ringGradient: null,
                fillColor: Colors.green[300]!,
                fillGradient: null,
                strokeWidth: 6.0,
                backgroundColor: Colors.grey[500],
                backgroundGradient: null,
                strokeCap: StrokeCap.round,
                textFormat: CountdownTextFormat.S,
                isTimerTextShown: true,
                autoStart: true,
                onStart: () {
                  debugPrint('Countdown Started');
                },
                // strokeCap: StrokeCap.round,
                textStyle: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                isReverse: true,
                onComplete: () {
                  print("complete");

                  // Handle when the countdown is completed
                },
                controller: _controller),
          ]),
          const SizedBox(
            height: 95,
          ),
          BlocBuilder<WordBloc, WordState>(
            builder: (context, state) {
              return Container(
                color: secondaryColor,
                child: SizedBox(
                    width: 350,
                    child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        alignment: WrapAlignment.center,
                        children:
                            List.generate(state.letters!.length + 1, (index) {
                          return Container(
                              margin: const EdgeInsets.only(right: 7),
                              child: (index < state.letters!.length)
                                  ? InkWell(
                                      splashColor: Colors.red,
                                      highlightColor: Colors.blue,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(2.1)),
                                      onTap:  !state.isOn ? () => context
                                          .read<WordBloc>()
                                          .add(SelectLetter(index)):null,
                                      child: Container(
                                        width: 50,
                                        margin: const EdgeInsets.all(11),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            //backgroundBlendMode: BlendMode.srcOver,
                                            border: Border.all(
                                              color: Colors.green,
                                              width: 2,
                                            )),
                                        child: Text(
                                          state.letters![index].value!,
                                          style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<WordBloc>()
                                            .add(DeleteOnLetter());
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red),
                                        /* minimumSize: MaterialStateProperty.all(Size(130, 40)),*/
                                        // elevation: MaterialStateProperty.all(0),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.backspace_outlined,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color!
                                            .withOpacity(0.64),
                                      ),
                                    ));
                        }))),
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 7.0),
            child: buildField(),
          ),
          const SizedBox(
            height: 15,
          ),
          BlocBuilder<WordBloc, WordState>(
            builder: (context, state) {
              return Text(style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
              ),
                  'Vous avez : ${(state.point == 1 || state.point == 0) ? '${state.point} point' : ' ${state.point} points'}');
            },
          ),
          const SizedBox(
            height: 15,
          ),
          floatingButton()
        ],
      ),
    );
  }

  Widget floatingButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
      /*  const SizedBox(
          width: 10,
        ),
        _button(title: "Start", onPressed: () => _controller.start()),*/
        const SizedBox(
          width: 10,
        ),
        _button(title: "Pause", onPressed: () {
           _controller.pause();
           context.read<WordBloc>().add(const IsGamePlay(true));
        }),
        const SizedBox(
          width: 10,
        ),
        _button(title: "Resume", onPressed: () {
          _controller.resume();
          context.read<WordBloc>().add(const IsGamePlay(false));
        }),
        const SizedBox(
          width: 10,
        ),
        _button(
            title: "Restart",
            onPressed: () {
              _controller.restart(duration: _secondsRemaining);
              context.read<WordBloc>().add(GenerateLetters());
            })
      ],
    );
  }

  Widget _button({required String title, VoidCallback? onPressed}) {
    return Expanded(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
            /* minimumSize: MaterialStateProperty.all(Size(130, 40)),*/
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),),
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    ));
  }

  Widget buildField() {
    return SafeArea(
      child: Column(
        children: [
          Container(
            width: 350,
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: defaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -4),
                  blurRadius: 32,
                  color: Colors.blue.withOpacity(0.08),
                ),
              ],
            ),
            child: Row(
              children: [
                //const SizedBox(width: 30),
                Expanded(
                  child: BlocBuilder<WordBloc, WordState>(
                      builder: (context, state) {
                    return TextField(
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                      ),
                      readOnly: true,
                      maxLines: 1,

                      controller:  TextEditingController(text: state.word.word),
                      //TextEditingController(text: chaine),
                      //Comment valide avec le bouton entre
                      decoration: InputDecoration(
                          errorText: (state.smsError.isNotEmpty)
                              ? state.smsError
                              : null,
                          suffixIcon: SizedBox(
                            width: 128,
                            height: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () => context.read<WordBloc>().add(
                                        ClearWord(),
                                      ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red),
                                    /* minimumSize: MaterialStateProperty.all(Size(130, 40)),*/
                                    elevation: MaterialStateProperty.all(0),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color!
                                        .withOpacity(0.64),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: !state.isOn ?  () {
                                    context.read<WordBloc>().add(FindWord());
                                  }: null,
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.green),
                                    /* minimumSize: MaterialStateProperty.all(Size(130, 40)),*/
                                    elevation: MaterialStateProperty.all(0),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.paperPlane,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color!
                                        .withOpacity(0.64),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
