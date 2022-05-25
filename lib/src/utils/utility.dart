import 'package:meta/meta.dart';

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
        return 49;
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

int getStep(double step) {
  if (step == 0.3) {
    return 0;
  } else if (step == 0.7) {
    return 1;
  } else if (step == 1) {
    return 2;
  } else if (step == 1.3) {
    return 3;
  } else if (step == 1.7) {
    return 4;
  } else if (step == 2) {
    return 5;
  } else if (step == 2.3) {
    return 6;
  } else if (step == 2.7) {
    return 7;
  } else if (step == 3) {
    return 8;
  } else if (step == 3.3) {
    return 9;
  } else if (step == 3.7) {
    return 10;
  } else if (step == 4) {
    return 11;
  } else if (step == 4.3) {
    return 12;
  } else if (step == 4.7) {
    return 13;
  } else if (step == 5) {
    return 14;
  } else if (step == 5.3) {
    return 15;
  } else if (step == 5.7) {
    return 16;
  } else if (step == 6) {
    return 17;
  } else if (step == 6.3) {
    return 18;
  } else if (step == 6.7) {
    return 19;
  } else if (step == 7) {
    return 20;
  } else if (step == 7.3) {
    return 21;
  } else if (step == 7.7) {
    return 22;
  } else if (step == 8) {
    return 23;
  } else if (step == 8.3) {
    return 24;
  } else if (step == 8.7) {
    return 25;
  } else if (step == 9) {
    return 26;
  }
  {
    return 0;
  }
}
