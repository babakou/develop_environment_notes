# M5 Stack弄り

## Wifi接続
正確にはM5Stack固有のAPIではなく、ESP32という通信モジュールのAPIを駆使する。

### 参考
[API Reference](https://docs.m5stack.com/#/en/api/wifi)
[ESP32をWiFiにつなげる - Qiita](https://qiita.com/hilucky/items/3e74d28c03d71f2f3caa)
[Arduino - ConnectWithWPA](https://www.arduino.cc/en/Tutorial/ConnectWithWPA)

### スケッチ
```
#include <M5Stack.h>
#include <WiFi.h>

const char ssid[] = "wx03-86c90d";
const char passwd[] = "102e0bef32e37";
void connectTo(const char* ssid, const char* passwd);

// the setup routine runs once when M5Stack starts up
void setup(){

  // Initialize the M5Stack object
  M5.begin();

  // LCD display
  M5.Lcd.println("Hello World!");
  M5.Lcd.println("M5Stack is running successfully!\n");
  connectTo(ssid, passwd);
}

// the loop routine runs over and over again forever
void loop() {

}

void connectTo(const char* ssid, const char* passwd) {
  int status = WL_IDLE_STATUS;
  int try_count = 1;

  M5.Lcd.println("M5Stack is connecting the Wifi network...");
  while (1) {
    M5.Lcd.print("Try count: ");
    M5.Lcd.println(try_count);
    status = WiFi.begin(ssid, passwd);

    if (status == WL_CONNECTED) {
      M5.Lcd.print("M5Stack connected the network! SSID: ");
      M5.Lcd.println(ssid);
      break;
    }
    else {
      if (try_count >= 10) {
        M5.Lcd.println("Connection Timed out.");
        break;
      }
      else  {
        M5.Lcd.println("Cannot connect. Try again after 10 seconds..");
        try_count++;
      }
    }

    delay(10000);
  }
}
```

これをUploadすると、モバイルルーター経由でLANにアクセスできて、ルータ側の
接続子機数も増えた！アクセスできたぞ！

## タイマ割り込み
これも正確にはM5Stack独自ではなくESP32の機能。

### 参考
[ESP32 Arduino: Timer interrupts – techtutorialsx](https://techtutorialsx.com/2017/10/07/esp32-arduino-timer-interrupts/)
[ESP32でのタイマー割り込みによる自動計測](http://marchan.e5.valueserver.jp/cabin/comp/jbox/arc202/doc21105.html)

