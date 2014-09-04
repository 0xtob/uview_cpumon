// Displays a gauge that gets its input values from serial.

#include <MicroView.h>

char buf[6];
MicroViewGauge *gauge;
int val;

void setup()
{
  uView.begin();
  Serial.begin(9600);
  uView.clear(PAGE);
  gauge = new MicroViewGauge(32,24,0,100);
}

void loop()
{
  if(Serial.available()) {
    val = Serial.parseInt();
    gauge->setValue(val);
  }
  uView.display();
  delay(100);
}
