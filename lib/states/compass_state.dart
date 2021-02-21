class CompassState {}

class Loading extends CompassState {}

class Success extends CompassState {
  double direction = 0;

  Success(this.direction);

}