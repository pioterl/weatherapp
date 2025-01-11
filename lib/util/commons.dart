double calculateMinYBelow0(double lowestTemperature) {
  if (lowestTemperature > -1.5) {
    return lowestTemperature - 3;
  } else if (lowestTemperature > -3) {
    return lowestTemperature - 3.5;
  } else if (lowestTemperature > -4) {
    return lowestTemperature - 5.5;
  } else if (lowestTemperature > -10) {
    return lowestTemperature * 1.4;
  } else if (lowestTemperature > -15) {
    return lowestTemperature * 1.2;
  } else {
    return lowestTemperature * 1.4;
  }
}
