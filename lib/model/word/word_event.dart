import 'package:equatable/equatable.dart';

abstract class WordEvent extends Equatable{
  const WordEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitEvent extends WordEvent {}
class SubmitEvent extends WordEvent {}
class GetWordDescription extends WordEvent {
  final String value;
  const GetWordDescription( this.value);
}
class GenerateLetters extends WordEvent {}
class ClearWord extends WordEvent {}
class FindWord extends WordEvent {}
class SelectLetter extends WordEvent {
  final num index;
  const SelectLetter( this.index);

}
class DeleteOnLetter extends WordEvent {}
class IsGamePlay extends WordEvent {
  final bool isGame;
  const IsGamePlay(this.isGame);
}



