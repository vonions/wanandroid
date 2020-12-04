import 'package:event_bus/event_bus.dart';

class EventBusUtil{


  static EventBus _bus;
  static getInstance(){

    if(_bus==null){
      _bus=EventBus();
    }

    return _bus;

  }
}