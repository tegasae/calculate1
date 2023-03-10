class InchToCM {
  final double _factor=2.54;
  
  double lengthInch=0;
  double overMeasureInch=0;
  int countOverMeasure=0;
  double _lengthCm=0;
  double _overMeasureCm=0;
  double _wholeLengthCm=0;

  InchToCM({required this.lengthInch, required this.overMeasureInch, required this.countOverMeasure}) {
    if ((lengthInch<0) || (overMeasureInch<0) || (countOverMeasure)<0) {
      throw("less than 0");
    }
    _lengthCm=(lengthInch*_factor);
    _overMeasureCm=(overMeasureInch*_factor);
    _wholeLengthCm=_lengthCm+countOverMeasure*_overMeasureCm;
  }

  double _toRound(double n) {
    int nInt=n.toInt();
    double afterComma=n-nInt;
    if (afterComma<=0.2) {
      return nInt.toDouble();
    }
    if (afterComma<=0.7) {
      return nInt.toDouble()+0.5;
    }
    return nInt.toDouble()+1;
  }
  double get wholeLengthCm  {

    return _toRound(_wholeLengthCm);
  }

  double get overMeasureCm => _toRound(_overMeasureCm);

  double get lengthCm => _toRound(_lengthCm);
}

