module BaremetalReference {

  # ----------------------------------------------------------------------
  # Symbolic constants for port numbers
  # ----------------------------------------------------------------------

    enum Ports_RateGroups {
      rateGroup1
    }

    enum Ports_StaticMemory {
      downlink
      uplink
      deframing
    }

  topology BaremetalReference {

    # ----------------------------------------------------------------------
    # Instances used in the topology
    # ----------------------------------------------------------------------

    instance blinker
    instance tlmSend
    instance cmdDisp
    instance commBufferManager
    instance commDriver
    instance commQueue
    instance downlink
    instance eventLogger
    instance fatalAdapter
    instance fatalHandler
    instance gpioDriver
    instance rateDriver
    instance rateGroup1
    instance rateGroupDriver
    instance rfm69
    instance staticMemory
    instance systemResources
    instance systemTime
    instance textLogger
    instance uplink

    # ----------------------------------------------------------------------
    # Pattern graph specifiers
    # ----------------------------------------------------------------------

    command connections instance cmdDisp

    event connections instance eventLogger

    telemetry connections instance tlmSend

    text event connections instance textLogger

    time connections instance systemTime

    # ----------------------------------------------------------------------
    # Direct graph specifiers
    # ----------------------------------------------------------------------

    connections Downlink {

      # tlmSend.PktSend -> commQueue.comQueueIn[0]
      # eventLogger.PktSend -> commQueue.comQueueIn[1]

      # commQueue.comQueueSend -> downlink.comIn

      # downlink.framedAllocate -> commBufferManager.bufferGetCallee
      # downlink.framedOut -> rfm69.comDataIn
      # # downlink.comStatusOut -> commQueue.comStatusIn
      # commDriver.deallocate -> commBufferManager.bufferSendIn

      # rfm69.drvDataOut -> commDriver.send
      # commDriver.ready -> rfm69.drvConnected
      # rfm69.comStatus -> commQueue.comStatusIn

      tlmSend.PktSend -> downlink.comIn
      eventLogger.PktSend -> downlink.comIn

      downlink.framedAllocate -> staticMemory.bufferAllocate[Ports_StaticMemory.downlink]
      downlink.framedOut -> commDriver.send

      commDriver.deallocate -> staticMemory.bufferDeallocate[Ports_StaticMemory.downlink]

    }

    connections FaultProtection {
      eventLogger.FatalAnnounce -> fatalHandler.FatalReceive
    }

    connections RateGroups {
      # Block driver
      rateDriver.CycleOut -> rateGroupDriver.CycleIn

      # Rate group 1
      rateGroupDriver.CycleOut[Ports_RateGroups.rateGroup1] -> rateGroup1.CycleIn
      rateGroup1.RateGroupMemberOut[0] -> commDriver.schedIn
      rateGroup1.RateGroupMemberOut[1] -> tlmSend.Run
      rateGroup1.RateGroupMemberOut[2] -> systemResources.run
      # rateGroup1.RateGroupMemberOut[3] -> commBufferManager.schedIn
      rateGroup1.RateGroupMemberOut[4] -> blinker.run
      rateGroup1.RateGroupMemberOut[5] -> rfm69.run
    }

    connections Uplink {

      # commDriver.allocate -> commBufferManager.bufferGetCallee
      # commDriver.$recv -> rfm69.drvDataIn
      # rfm69.comDataOut -> uplink.framedIn
      # uplink.framedDeallocate -> commBufferManager.bufferSendIn

      # uplink.comOut -> cmdDisp.seqCmdBuff
      # cmdDisp.seqCmdStatus -> uplink.cmdResponseIn

      # uplink.bufferAllocate -> commBufferManager.bufferGetCallee
      # uplink.bufferDeallocate -> commBufferManager.bufferSendIn

      commDriver.allocate -> staticMemory.bufferAllocate[Ports_StaticMemory.uplink]
      commDriver.$recv -> uplink.framedIn
      uplink.framedDeallocate -> staticMemory.bufferDeallocate[Ports_StaticMemory.uplink]

      uplink.comOut -> cmdDisp.seqCmdBuff
      cmdDisp.seqCmdStatus -> uplink.cmdResponseIn

      uplink.bufferAllocate -> staticMemory.bufferAllocate[Ports_StaticMemory.deframing]
      uplink.bufferDeallocate -> staticMemory.bufferDeallocate[Ports_StaticMemory.deframing]

    }

    # connections Radio {
    #   rfm69.allocate -> commBufferManager.bufferGetCallee
    #   rfm69.deallocate -> commBufferManager.bufferSendIn
    # }

    connections BaremetalReference {
      # Add here connections to user-defined components
      blinker.gpioSet -> gpioDriver.gpioWrite
    }

  }

}
