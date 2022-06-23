class SmartTV {
  int _channel = 2;
  int _volume = 0;
}

class RemoteControl {
  SmartTV _tv;

  RemoteControl(SmartTV tv) : _tv = tv;

  void volumeUp(int levels)
}

void main() {
  SmartTV tv1 = SmartTV();
  SmartTV tv2 = SmartTV();

  RemoteControl rc1 = RemoteControl(tv1);
}
