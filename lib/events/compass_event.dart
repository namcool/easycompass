import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class CompassEvent extends Equatable {
}
class ChangeDirectionCompassEvent extends CompassEvent {
  final double direction;

  ChangeDirectionCompassEvent(this.direction);

@override
  // TODO: implement props
  List<Object> get props => [direction];
}