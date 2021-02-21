import 'package:compasswithbloc/events/compass_event.dart';
import 'package:compasswithbloc/states/compass_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompassBloc extends Bloc<CompassEvent, CompassState> {
  double direction = 0;

  @override
  CompassBloc(CompassState initialState) : super(Success(0));


  @override
  Stream<CompassState> mapEventToState(CompassEvent event) async* {
    // TODO: implement mapEventToState
    if (event is ChangeDirectionCompassEvent) {
      //yield Loading();
      await Future.delayed(Duration(milliseconds: 50));
      yield Success(event.direction);
    }
  }

}