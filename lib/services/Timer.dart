
class Timer{
  int secondsBetweenCommand;
  Function command;
  bool keepGoing = true;

  Timer({this.secondsBetweenCommand, this.command});

  void startTimer() async{
    command.call();
    await Future.delayed(Duration(seconds: secondsBetweenCommand));
    keepGoing ? startTimer() : null;
  }

  void stopTimer(){
    keepGoing = false;
  }

  void waitStartTimer(seconds) async {
    await Future.delayed(Duration(seconds: seconds));
    startTimer();
  }
}