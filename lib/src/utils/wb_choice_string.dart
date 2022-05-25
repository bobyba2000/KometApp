extension WbChoiceString on String {
  String fullName() {
    try {
      int startIndex = 0, indexOfSpace;

      indexOfSpace = this.indexOf(' ', startIndex);

      return this.substring(0, indexOfSpace);
    } catch (e) {
      return this;
    }
  }

  String abreviation() {
    try {
      const start = "(";
      const end = ")";

      final startIndex = this.indexOf(start);
      final endIndex = this.indexOf(end, startIndex + start.length);

      return this.substring(startIndex + start.length, endIndex);
    } catch (e) {
      print("$e");

      return this;
    }
  }
}
