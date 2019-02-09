int mydelay = 1000 ;

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(115200);
}

void loop() {
  Serial.println("HIGH");
  digitalWrite(LED_BUILTIN, HIGH);
  delay(mydelay);

  Serial.println("LOW");
  digitalWrite(LED_BUILTIN, LOW);
  delay(mydelay);
}
