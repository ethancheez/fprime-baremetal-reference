// ======================================================================
// \title  RFM69.hpp
// \author ethanchee
// \brief  hpp file for RFM69 component implementation class
// ======================================================================

#ifndef RFM69_HPP
#define RFM69_HPP

#include "BaremetalReference/Radio/RFM69/RFM69ComponentAc.hpp"
#include "RH_RF69.h"

namespace Radio {

  class RFM69 :
    public RFM69ComponentBase
  {

    public:

      // ----------------------------------------------------------------------
      // Construction, initialization, and destruction
      // ----------------------------------------------------------------------

      //! Construct object RFM69
      //!
      RFM69(
          const char *const compName /*!< The component name*/
      );

      //! Destroy object RFM69
      //!
      ~RFM69();

      void reset();
      void send();
      void recv();

    PRIVATE:

      // ----------------------------------------------------------------------
      // Handler implementations for user-defined typed input ports
      // ----------------------------------------------------------------------

      //! Handler implementation for run
      //!
      void run_handler(
          const NATIVE_INT_TYPE portNum, /*!< The port number*/
          NATIVE_UINT_TYPE context /*!< 
      The call order
      */
      );

    PRIVATE:

      // ----------------------------------------------------------------------
      // Command handler implementations
      // ----------------------------------------------------------------------

      //! Implementation for SEND_PACKET command handler
      //! Command to send packet
      void SEND_PACKET_cmdHandler(
          const FwOpcodeType opCode, /*!< The opcode*/
          const U32 cmdSeq, /*!< The command sequence number*/
          U32 packet 
      );

      RH_RF69 rfm69;
      bool is_in_reset;
      Fw::On radio_state;
      U16 pkt_count;
    };

} // end namespace Radio

#endif
