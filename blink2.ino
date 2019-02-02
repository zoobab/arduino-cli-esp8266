void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(115200);
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH);
  Serial.print("high\n");
  delay(2000);
  digitalWrite(LED_BUILTIN, LOW);
  Serial.print("low\n");
  delay(2000);
}
