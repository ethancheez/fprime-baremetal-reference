module BaremetalReference {

  # ----------------------------------------------------------------------
  # Defaults
  # ----------------------------------------------------------------------

  module Default {
    constant QUEUE_SIZE = 3
    constant STACK_SIZE = 64 * 1024
  }

  # ----------------------------------------------------------------------
  # Active component instances
  # ----------------------------------------------------------------------

  instance cmdDisp: Svc.CommandDispatcher base id 0x0500 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 101

  instance commQueue: Svc.ComQueue base id 0x0600 \
      queue size 15 \
      stack size Default.STACK_SIZE \
      priority 100 \

  instance eventLogger: Svc.ActiveLogger base id 0x0B00 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 98

  instance tlmSend: Svc.TlmChan base id 0x0C00 \
    queue size 15 \
    stack size Default.STACK_SIZE \
    priority 97

  # ----------------------------------------------------------------------
  # Queued component instances
  # ----------------------------------------------------------------------

  # ----------------------------------------------------------------------
  # Passive component instances
  # ----------------------------------------------------------------------

  instance rateGroup1: Svc.PassiveRateGroup base id 0x0200

  instance rateGroup2: Svc.PassiveRateGroup base id 0x0300

  instance framer: Svc.Framer base id 0x4000

  instance fatalAdapter: Svc.AssertFatalAdapter base id 0x4100

  instance fatalHandler: Svc.FatalHandler base id 0x4200

  instance systemTime: Svc.Time base id 0x4300 \
    type "Svc::ArduinoTimeImpl" \
    at "../../lib/arduino/fprime-arduino/Arduino/ArduinoTime/ArduinoTimeImpl.hpp"

  instance rateGroupDriver: Svc.RateGroupDriver base id 0x4400

  instance staticMemory: Svc.StaticMemory base id 0x4500

  instance textLogger: Svc.PassiveTextLogger base id 0x4600

  instance deframer: Svc.Deframer base id 0x4700

  instance systemResources: Svc.SystemResources base id 0x4800

  instance rateDriver: Arduino.HardwareRateDriver base id 0x4900

  instance gpioDriver: Arduino.GpioDriver base id 0x5000

  instance i2cDriver: Arduino.I2cDriver base id 0x5100

  instance blinker: Components.LedBlinker base id 0x10000

  instance rfm69: Radio.RFM69 base id 0x10100

  instance imu: Sensors.IMU_MPU9250 base id 0x10200

}
