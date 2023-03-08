import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../letter.dart';
import '../word.dart';
import '../word_repository.dart';
import 'word_event.dart';
import 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final List<String> _consonants = [
    'B',
    'C',
    'D',
    'F',
    'G',
    'H',
    'J',
    'K',
    'L',
    'M',
    'N',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];
  final List<String> _vowels = ['A', 'E', 'I', 'O', 'U'];

  List<Letter> _letters = [];

  List<Letter> get letters => _letters;

  WordBloc(WordRepository repository)
      : _repository = repository,
        super(const WordState()) {
    on<ClearWord>(_clearWord);
    on<GenerateLetters>(_generateLetters);
    on<SelectLetter>(_concatWord);
    on<DeleteOnLetter>(_deleteOneLetter);
    on<FindWord>(_findWordRequest);
    on<IsGamePlay>(_isGamePlay);

  }

  final WordRepository _repository;

  void _generateLetters(GenerateLetters event, Emitter<WordState> emit) {
    _letters = [];
    var result = '';
    if (state.letters!.isEmpty) { }
      for (var i = 0; i < 10; i++) {
        var index = DateTime.now().millisecondsSinceEpoch % _consonants.length;
        if (!result.contains(_consonants[index])) {
          _letters.add(Letter(value: _consonants[index].toLowerCase()));
          result += _consonants[index];
        } else {
          i--;
        }
      }
      for (var index = 0; index < _vowels.length; index++) {
        _letters.add(Letter(value: _vowels[index].toLowerCase()));
      }
      _letters.shuffle();
      emit(state.lettersGenerated(_letters));

  }

  void _concatWord(SelectLetter event, Emitter<WordState> emit) {
    var strChain = "";
    strChain = (state.word.word + state.letters![event.index as int].value!)
        .toLowerCase();
    var word = Word(word:strChain,isCorrect: true );
    emit(state.concatWord(word, state.letters!, state.point!, state.wordFind!));
  }

  void _clearWord(ClearWord event, Emitter<WordState> emit) {
    print("Je suis tres heureux");

    emit(state.concatWord(const Word(word:'',isCorrect: true ), state.letters!, state.point!, state.wordFind!));

  }

void _isGamePlay(IsGamePlay event, Emitter<WordState> emit) {

    emit(state.isGamePlay(event.isGame, state.word, state.letters!, state.point!, state.wordFind!,state.smsError));

  }


  void _deleteOneLetter(DeleteOnLetter event, Emitter<WordState> emit) {
    int length = state.word.word.length;
    var strChain = state.word.word.substring(0, length - 1);
    emit(state.concatWord(
         Word(word:strChain,isCorrect: true ), state.letters!, state.point!, state.wordFind!));
  }

  Future<void> _findWordRequest(FindWord event, Emitter<WordState> emit) async {
    var strChain = state.word.word;
    bool isCorrect = false;
    final List<String> wordFind = state.wordFind!.map((e) => e).toList();
    var total = state.point!;
    var error = state.smsError;
    if (strChain.isNotEmpty) {
      if (state.wordFind!.contains(strChain)) {
        error = "word is already";
        emit(state.getWordFind(state.letters!, total, wordFind, error));
        return;
      }
      if (strChain.length == 2) {
        if (("aoieu".contains(strChain.substring(0)) &&
                !"aoieu".contains(strChain.substring(1))) ||
            (!"aoieu".contains(strChain.substring(0)) &&
                "aoieu".contains(strChain.substring(1)))) {
          isCorrect = await _repository.getWordDescription(strChain);
        }
      }
      if (strChain.length >= 3) {
        isCorrect = await _repository.getWordDescription(strChain);
      }
      if (isCorrect) {
        total += strChain.length;
        wordFind.add(strChain);
      } else {
        error = "Incorrect word";
      }
      emit(state.getWordFind(state.letters!, total, wordFind, error));
    }
  }


}
