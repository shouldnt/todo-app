import '../constants.dart';

String dateDbFormat(DateTime date) {
  return date.toIso8601String();
}

int priorityEnumToNumber(Priorities priority) {
  switch(priority) {
    case Priorities.low: {
      return 1;
    }
    case Priorities.high: {
      return 5;
    }
    default: {
      return 3;
    }
  }
}
Priorities numberToPriorityEnum(int value) {
  switch(value) {
    case 1: {
      return Priorities.low;
    }
    case 5: {
      return Priorities.high;
    }
    default: {
      return Priorities.medium;
    }
  }
}