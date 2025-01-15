double calculateMinYBelow0(double lowestTemperature) {
  if (lowestTemperature >= -1.5) {
    return lowestTemperature - 2.5;
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

double calculateMaxY(double maxTemp) {
  if (maxTemp > 35) {
    return maxTemp * 1.1;
  } else if (maxTemp > 25) {
    return maxTemp * 1.25;
  } else if (maxTemp > 10) {
    return maxTemp + 3.5;
  } else if (maxTemp > 0) {
    return maxTemp + 2.0;
  } else if (maxTemp <= 0) {
    return 0.1;
  }
  return maxTemp * 1.5;
}
