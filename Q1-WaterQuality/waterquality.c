#include <math.h>
#include <stdio.h>

#define REFERENCE_TEMPERATURE 25.0f

float temperature_deviation(float temperature) {
  return fabsf(temperature - REFERENCE_TEMPERATURE);
}

float turbidity_penalty(float turbidity) { return turbidity / 2.0f; }

float water_quality_index(float temperature, float turbidity) {
  float deviation = temperature_deviation(temperature);
  float penalty = turbidity_penalty(turbidity);
  return 100.0f - (deviation + penalty);
}

const char *classify_quality(float index) {
  if (index >= 80.0f) {
    return "Good";
  } else if (index >= 60.0f) {
    return "Warning";
  } else {
    return "Critical";
  }
}

void print_report(float temperature, float turbidity, float index) {
  printf("\n");
  printf("|-|-|-|WATER QUALITY MONITORING REPORT|-|-|-|\n\n");
  printf(" Sensor readings\n");
  printf("\nTemperature : %8.2f °C\n", temperature);
  printf("Turbidity : %8.2f NTU\n", turbidity);
  printf("\n");

  printf(" Index calculation\n");
  printf("\nTemperatureDeviation = (%.2f - 25) = %.2f °C\n", temperature,
         temperature_deviation(temperature));
  printf("TurbidityPenalty = (%.2f / 2) = %.2f °C\n", turbidity,
         turbidity_penalty(turbidity));
  printf("Index = 100 - (%.2f + %2.f) = %.2f\n",
         temperature_deviation(temperature), turbidity_penalty(turbidity),
         index);
  printf("\n");
  printf("  Result\n");
  printf("\nWater Quality Index :  %8.2f\n", index);
  printf("Status:  %s\n", classify_quality(index));
  printf("=====================================================\n");
}

int main() {
  float temperature;
  float turbidity;
  float index;

  printf("Water Quality Sensor Input\n");
  printf("\n Enter temperature (°C): ");
  if (scanf("%f", &temperature) != 1) {
    printf("Error: Temperature must be a number.\n");
    return 1;
  }
  printf("Enter turbidity (NTU): ");
  if (scanf("%f", &turbidity) != 1) {
    printf("Error: turbidity must be a runner\n");
    return 1;
  }

  index = water_quality_index(temperature, turbidity);
  print_report(temperature, turbidity, index);
  return 0;
}