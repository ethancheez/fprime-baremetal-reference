module RadioPassthrough {

  # ----------------------------------------------------------------------
  # Symbolic constants for port numbers
  # ----------------------------------------------------------------------

    enum Ports_RateGroups {
      rateGroup1
    }

    enum Ports_StaticMemory {
      downlink
      uplink
    }

  topology RadioPassthrough {

    # ----------------------------------------------------------------------
    # Instances used in the topology
    # ----------------------------------------------------------------------

    instance blinker
    instance commDriver
    instance gpioDriver
    instance rateDriver
    instance rateGroup1
    instance rateGroupDriver
    instance rfm69
    instance staticMemory
    instance streamCrossoverUplink
    instance streamCrossoverDownlink
    instance systemTime
    instance textLogger

    instance eventLogger
    instance fatalAdapter
    instance fatalHandler

    # ----------------------------------------------------------------------
    # Pattern graph specifiers
    # ----------------------------------------------------------------------

    text event connections instance textLogger

    event connections instance eventLogger

    time connections instance systemTime

    # ----------------------------------------------------------------------
    # Direct graph specifiers
    # ----------------------------------------------------------------------

    connections FaultProtection {
      eventLogger.FatalAnnounce -> fatalHandler.FatalReceive
    }

    connections RateGroups {
      # Block driver
      rateDriver.CycleOut -> rateGroupDriver.CycleIn

      # Rate group 1
      rateGroupDriver.CycleOut[Ports_RateGroups.rateGroup1] -> rateGroup1.CycleIn
      rateGroup1.RateGroupMemberOut[0] -> commDriver.schedIn
      rateGroup1.RateGroupMemberOut[1] -> blinker.run
      rateGroup1.RateGroupMemberOut[2] -> rfm69.run
    }

    connections Downlink {

      rfm69.allocate -> staticMemory.bufferAllocate[Ports_StaticMemory.downlink]
      rfm69.comDataOut -> streamCrossoverDownlink.streamIn
      streamCrossoverDownlink.streamOut -> commDriver.send
      commDriver.deallocate -> staticMemory.bufferDeallocate[Ports_StaticMemory.downlink]

    }

    connections Uplink {

      commDriver.allocate -> staticMemory.bufferAllocate[Ports_StaticMemory.uplink]
      commDriver.$recv -> streamCrossoverUplink.streamIn
      streamCrossoverUplink.streamOut -> rfm69.comDataIn
      rfm69.deallocate -> staticMemory.bufferDeallocate[Ports_StaticMemory.uplink]

    }

    connections RadioPassthrough {
      # Add here connections to user-defined components
      blinker.gpioSet -> gpioDriver.gpioWrite
    }

  }

}
