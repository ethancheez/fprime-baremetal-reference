module SystemRef {

  # ----------------------------------------------------------------------
  # Defaults
  # ----------------------------------------------------------------------

  module Default {
    constant QUEUE_SIZE = 10
    constant STACK_SIZE = 32 * 1024
  }

  # ----------------------------------------------------------------------
  # Active component instances
  # ----------------------------------------------------------------------

  instance rateGroup1: Svc.ActiveRateGroup base id 0x0200 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 120

  instance cmdDisp: Svc.CommandDispatcher base id 0x0500 \
    queue size 5 \
    stack size Default.STACK_SIZE \
    priority 101

  #instance cmdSeq: Svc.CmdSequencer base id 0x0600 \
  #  queue size Default.QUEUE_SIZE \
  #  stack size Default.STACK_SIZE \
  #  priority 100

  instance eventLogger: Svc.ActiveLogger base id 0x0B00 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 98

  #instance fileDownlink: Svc.FileDownlink base id 0x0700 \
  #  queue size Default.QUEUE_SIZE \
  #  stack size Default.STACK_SIZE \
  #  priority 100

  #instance fileManager: Svc.FileManager base id 0x0800 \
  #  queue size 30 \
  #  stack size Default.STACK_SIZE \
  #  priority 100

  #instance fileUplink: Svc.FileUplink base id 0x0900 \
  #  queue size Default.QUEUE_SIZE \
  #  stack size Default.STACK_SIZE \
  #  priority 100

  # comment in Svc.TlmChan or Svc.TlmPacketizer
  # depending on which form of telemetry downlink
  # you wish to use

  instance tlmSend: Svc.TlmChan base id 0x0C00 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 97

  #instance tlmSend: Svc.TlmPacketizer base id 0x0C00 \
  #    queue size Default.QUEUE_SIZE \
  #    stack size Default.STACK_SIZE \
  #    priority 97

  #instance prmDb: Svc.PrmDb base id 0x0D00 \
  #  queue size Default.QUEUE_SIZE \
  #  stack size Default.STACK_SIZE \
  #  priority 96

  #instance commQueue: Svc.ComQueue base id 0x0E00 \
  #    queue size Default.QUEUE_SIZE \
  #    stack size Default.STACK_SIZE \
  #    priority 100

  instance blinker: SystemRef.LedBlinker base id 0x0F00 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 95

  # ----------------------------------------------------------------------
  # Queued component instances
  # ----------------------------------------------------------------------

  #instance $health: Svc.Health base id 0x2000 \
  #  queue size 25

  # ----------------------------------------------------------------------
  # Passive component instances
  # ----------------------------------------------------------------------

  instance downlink: Svc.Framer base id 0x4100

  instance fatalAdapter: Svc.AssertFatalAdapter base id 0x4200

  instance fatalHandler: Svc.FatalHandler base id 0x4300

  #instance fileUplinkBufferManager: Svc.BufferManager base id 0x4400

  instance systemTime: Svc.Time base id 0x4500 \
    type "Svc::ArduinoTimeImpl" \
    at "../../arduino/fprime-arduino/Arduino/ArduinoTime/ArduinoTimeImpl.hpp"

  instance rateGroupDriver: Svc.RateGroupDriver base id 0x4600

  instance staticMemory: Svc.StaticMemory base id 0x4700

  instance textLogger: Svc.PassiveTextLogger base id 0x4800

  instance uplink: Svc.Deframer base id 0x4900

  #instance systemResources: Svc.SystemResources base id 0x4A00

  instance rateDriver: Arduino.HardwareRateDriver base id 0x4B00

  instance commDriver: Arduino.SerialDriver base id 0x4000

  instance gpioDriver: Arduino.GpioDriver base id 0x4C00

}
