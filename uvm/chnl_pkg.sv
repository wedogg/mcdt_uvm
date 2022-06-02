package chnl_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  typedef struct packed {
    bit[31:0] data;
    bit[1:0] id;
  } mon_data_t;

  `include "chnl_agent_config.svh"
  `include "mcdt_agent_config.svh"
  `include "env_config.svh"
  `include "chnl_sequence_item.svh"
  `include "chnl_sequencer.svh"
  `include "chnl_sequence.svh"
  `include "chnl_driver.svh"
  `include "chnl_monitor.svh"
  `include "mcdt_monitor.svh"
  `include "coverage.svh"
  `include "my_scoreboard.svh"
  `include "chnl_agent.svh"
  `include "mcdt_agent.svh"
  `include "env.svh"
  `include "my_test.svh"

endpackage