class chnl_agent extends uvm_agent;
  
  `uvm_component_utils(chnl_agent);

  chnl_agent_config chnl_agent_config_h;
  virtual chnl_bfm chnl_if;
  chnl_driver driver_h;
  chnl_monitor monitor_h;
  chnl_sequencer sequencer_h;

  function new(string name = "chnl_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db #(chnl_agent_config)::get(this, "", "config", chnl_agent_config_h))
      $fatal("Failed to get BFM");

    chnl_if = chnl_agent_config_h.chnl_if;
    driver_h = chnl_driver::type_id::create("driver_h", this);
    monitor_h = chnl_monitor::type_id::create("monitor_h", this);
    sequencer_h = chnl_sequencer::type_id::create("sequencer_h", this);
    uvm_config_db #(virtual chnl_bfm)::set(this, "driver_h", "config", chnl_if);
    uvm_config_db #(virtual chnl_bfm)::set(this, "monitor_h", "config", chnl_if);
//    uvm_config_db #(virtual chnl_bfm)::set(this, "sequencer_h", "config", chnl_if);

  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
//connect the driver and sequencer
    driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
  endfunction

endclass