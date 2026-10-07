const int TRIG_PIN = 9;
const int ECHO_PIN = 10;
const int GREEN_LED_PIN = 6;
const int RED_LED_PIN = 7;
const int BUZZER_PIN = 8;
const int OCCUPIED_THRESHOLD_CM = 15;
const float SPEED_OF_SOUND_CM_PER_US = 0.0343;
const int ALERT_TONE_HZ = 1000;
const float NO_ECHO = -1.0;

float measureDistanceCm() {

  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);

  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);

  unsigned long duration = pulseIn(ECHO_PIN, HIGH, 30000UL);

  if (duration == 0) {
    return NO_ECHO;
  }
  return (duration * SPEED_OF_SOUND_CM_PER_US) / 2.0;
}

void updateIndicators(bool occupied) {
  if (occupied) {
    digitalWrite(GREEN_LED_PIN, LOW);
    digitalWrite(RED_LED_PIN, HIGH);
    tone(BUZZER_PIN, ALERT_TONE_HZ);
  } else {
    digitalWrite(GREEN_LED_PIN, HIGH);
    digitalWrite(RED_LED_PIN, LOW);
    noTone(BUZZER_PIN);
  }
}

void setup() {
  Serial.begin(9600);

  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  pinMode(GREEN_LED_PIN, OUTPUT);
  pinMode(RED_LED_PIN, OUTPUT);
  pinMode(BUZZER_PIN, OUTPUT);

  Serial.println("|-|-|-| SMART PARKING SYSTEM |-|-|-|");
  Serial.print("Occupancy threshold: ");
  Serial.print(OCCUPIED_THRESHOLD_CM);
  Serial.println(" cm");
  Serial.println("|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|");
}

void loop() {
  float distance = measureDistanceCm();

  bool occupied = (distance != NO_ECHO && distance <= OCCUPIED_THRESHOLD_CM);

  updateIndicators(occupied);

  Serial.print("Distance: ");
  if (distance < 0) {
    Serial.print("no echo    ");
  } else {
    Serial.print(distance);
    Serial.print(" cm");
  }
  Serial.print("  |  Status: ");
  if (occupied) {
    Serial.println("OCCUPIED  (Red LED ON,  Green LED OFF, Buzzer ON)");
  } else {
    Serial.println("FREE      (Green LED ON, Red LED OFF,  Buzzer OFF)");
  }

  delay(300);
}
