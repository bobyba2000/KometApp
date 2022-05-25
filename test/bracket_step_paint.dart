import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

final List<double> _values = [
  -9,
  -8.6,
  -8.3,
  -8.0,
  -7.6,
  -7.3,
  -7,
  -6.6,
  -6.3,
  -6,
  -5.6,
  -5.3,
  -5,
  -4.6,
  -4.3,
  -4,
  -3.6,
  -3.3,
  -3,
  -2.6,
  -2.3,
  -2,
  -1.6,
  -1.3,
  -1,
  -0.6,
  -0.3,
  0,
  0.3,
  0.6,
  1,
  1.3,
  1.6,
  2,
  2.3,
  2.6,
  3,
  3.3,
  3.6,
  4,
  4.3,
  4.6,
  5,
  5.3,
  5.6,
  6,
  6.3,
  6.6,
  7,
  7.3,
  7.6,
  8,
  8.3,
  8.6,
  9
];

void main() {
  test('check steps', () {
    expect(checkSteps(bracket: 11, step: 0.7), 21);
  });

  test('check steps', () {
    expect(checkSteps(bracket: 11, step: 0.7), 21);
  });
}

isInRange({@required int curItem, @required int i, @required int range}) {
  int first = curItem;
  int last = curItem;

  if (curItem >= range) {
    double r = ((range - 1) / 2);
    //  print("range left $r");
    first = curItem - r.toInt();
  }

  if (curItem <= _values.length) {
    double r = ((range - 1) / 2);
    // print("range right $r");
    last = curItem + r.toInt();
  }
}

//returns number of bars that are in painting bracket based on steps
int checkSteps({@required int bracket, @required double step}) {
  if (step == 0.3) {
    return bracket;
  } else if (step == 0.7) {
    switch (bracket) {
      case 3:
        return 5;
        break;
      case 5:
        return 9;
        break;
      case 7:
        return 13;
        break;
      case 9:
        return 17;
        break;
      case 11:
        return 21;
        break;
      case 13:
        return 25;
        break;
      case 15:
        return 29;
        break;
      case 17:
        return 33;
        break;
      case 19:
        return 37;
        break;
      default:
        return 0;
    }
  } else if (step == 1) {
    switch (bracket) {
      case 3:
        return 7;
        break;
      case 5:
        return 13;
        break;
      case 7:
        return 19;
        break;
      case 9:
        return 25;
        break;
      case 11:
        return 31;
        break;
      case 13:
        return 37;
        break;
      case 15:
        return 43;
        break;
      case 17:
        return 33;
        break;
      case 19:
        return 55;
        break;
      default:
        return 0;
    }
  } else if (step == 1.3) {
    switch (bracket) {
      case 3:
        return 9;
        break;
      case 5:
        return 17;
        break;
      case 7:
        return 25;
        break;
      case 9:
        return 33;
        break;
      case 11:
        return 41;
        break;
      case 13:
        return 49;
        break;

      default:
        return 0;
    }
  } else if (step == 1.7) {
    switch (bracket) {
      case 3:
        return 11;
        break;
      case 5:
        return 21;
        break;
      case 7:
        return 31;
        break;
      case 9:
        return 41;
        break;
      case 11:
        return 51;
        break;

      default:
        return 0;
    }
  } else if (step == 2) {
    switch (bracket) {
      case 3:
        return 13;
        break;
      case 5:
        return 25;
        break;
      case 7:
        return 37;
        break;
      case 9:
        return 49;
        break;
      default:
        return 0;
    }
  } else if (step == 2.3) {
    switch (bracket) {
      case 3:
        return 15;
        break;
      case 5:
        return 29;
        break;
      case 7:
        return 43;
        break;

      default:
        return 0;
    }
  } else if (step == 2.7) {
    switch (bracket) {
      case 3:
        return 17;
        break;
      case 5:
        return 33;
        break;
      case 7:
        return 49;
        break;

      default:
        return 0;
    }
  } else if (step == 3) {
    switch (bracket) {
      case 3:
        return 19;
        break;
      case 5:
        return 37;
        break;

      default:
        return 0;
    }
  } else if (step == 3.3) {
    switch (bracket) {
      case 3:
        return 21;
        break;
      case 5:
        return 41;
        break;

      default:
        return 0;
    }
  } else if (step == 3.7) {
    switch (bracket) {
      case 3:
        return 23;
        break;
      case 5:
        return 45;
        break;

      default:
        return 0;
    }
  } else if (step == 4) {
    switch (bracket) {
      case 3:
        return 25;
        break;
      case 5:
        return 49;
        break;

      default:
        return 0;
    }
  } else if (step == 4.3) {
    switch (bracket) {
      case 3:
        return 27;
        break;
      case 5:
        return 53;
        break;

      default:
        return 0;
    }
  } else if (step == 4.7) {
    switch (bracket) {
      case 3:
        return 29;
        break;

      default:
        return 0;
    }
  } else if (step == 5) {
    switch (bracket) {
      case 3:
        return 31;
        break;

      default:
        return 0;
    }
  } else if (step == 5.3) {
    switch (bracket) {
      case 3:
        return 33;
        break;

      default:
        return 0;
    }
  } else if (step == 5.7) {
    switch (bracket) {
      case 3:
        return 35;
        break;

      default:
        return 0;
    }
  } else if (step == 6) {
    switch (bracket) {
      case 3:
        return 37;
        break;

      default:
        return 0;
    }
  } else if (step == 6.3) {
    switch (bracket) {
      case 3:
        return 39;
        break;

      default:
        return 0;
    }
  } else if (step == 6.7) {
    switch (bracket) {
      case 3:
        return 41;
        break;

      default:
        return 0;
    }
  } else if (step == 7) {
    switch (bracket) {
      case 3:
        return 43;
        break;

      default:
        return 0;
    }
  } else if (step == 7.3) {
    switch (bracket) {
      case 3:
        return 45;
        break;

      default:
        return 0;
    }
  } else if (step == 7.7) {
    switch (bracket) {
      case 3:
        return 47;
        break;

      default:
        return 0;
    }
  } else if (step == 8) {
    switch (bracket) {
      case 3:
        return 49;
        break;

      default:
        return 0;
    }
  } else if (step == 8.3) {
    switch (bracket) {
      case 3:
        return 51;
        break;

      default:
        return 0;
    }
  } else if (step == 8.7) {
    switch (bracket) {
      case 3:
        return 53;
        break;

      default:
        return 0;
    }
  } else if (step == 9) {
    switch (bracket) {
      case 3:
        return 55;
        break;

      default:
        return 0;
    }
  } else {
    return 0;
  }
}
