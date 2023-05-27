// ======================================================================
// \title  RFM69.hpp
// \author ethanchee
// \brief  hpp file for RFM69 component implementation class
// ======================================================================

#ifndef RFM69_HPP
#define RFM69_HPP

#include "BaremetalReference/Radio/RFM69/RFM69ComponentAc.hpp"
#include "Utils/Types/CircularBuffer.hpp"
#include "RH_RF69.h"

namespace Radio {

  #define RFM69_FREQ 915.0
  #define RFM69_CS    8
  #define RFM69_INT   3
  #define RFM69_RST   4

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

      void recv();

    PRIVATE:

      // ----------------------------------------------------------------------
      // Handler implementations for user-defined typed input ports
      // ----------------------------------------------------------------------

      //! Handler implementation for comDataIn
      //!
      Drv::SendStatus comDataIn_handler(
          const NATIVE_INT_TYPE portNum, /*!< The port number*/
          Fw::Buffer &sendBuffer 
      );

      //! Handler implementation for drvConnected
      //!
      void drvConnected_handler(
          const NATIVE_INT_TYPE portNum /*!< The port number*/
      );

      //! Handler implementation for drvDataIn
      //!
      void drvDataIn_handler(
          const NATIVE_INT_TYPE portNum, /*!< The port number*/
          Fw::Buffer &recvBuffer, 
          const Drv::RecvStatus &recvStatus 
      );

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
          const Fw::CmdStringArg& payload 
      );

      RH_RF69 rfm69;
      bool is_in_reset;
      Fw::On radio_state;
      U16 pkt_rx_count;
      U16 pkt_tx_count;

      Types::CircularBuffer m_circular;
      U8 m_data[RH_RF69_MAX_MESSAGE_LEN + 1];
      bool m_reinit;
    };

} // end namespace Radio

#endif
