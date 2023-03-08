import 'package:equatable/equatable.dart';

import '../letter.dart';
import '../word.dart';

class WordState extends Equatable {
  final bool isOn;
  final Word word ;
  final String smsError ;
  final List<Letter>? letters ;
  final List<String>? wordFind ;
  final int? point;

  const WordState( {
   this.isOn=false,
    this.point=0,
    this.smsError='',
    this.wordFind = const [],
   this.letters = const [],
   this.word = const Word(word: '',isCorrect: false)
 });

  WordState lettersGenerated(List<Letter>  letters) {
     return WordState(letters: letters);
  }
  WordState concatWord(Word strChain ,List<Letter>  letters,int pts,List<String> wordFind ) {
    return WordState(word: strChain ,letters:letters, wordFind: wordFind,point: pts );
  }

  @override
  List<Object?> get props => [ isOn ,letters, word,point ,smsError, wordFind] ;

  WordState getWordFind(List<Letter> list, int pts,List<String> wordFind,String smsError) {

    return WordState(letters:letters ,point: pts , wordFind: wordFind, smsError: smsError);
  }
  WordState isGamePlay(bool isPause,Word strChain,List<Letter> list, int pts,List<String> wordFind,String smsError){

    return WordState( isOn:isPause , word: strChain, letters:letters ,point: pts , wordFind: wordFind, smsError: smsError);

  }
}

