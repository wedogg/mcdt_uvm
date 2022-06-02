class mcdt_agent extends uvm_agent;
  `uvm_component_utils(mcdt_agent);

  mcdt_monitor monitor;
  virtual mcdt_bfm mcdt_if;
  mcdt_agent_config mcdt_agent_config_h;

  function new(string name = "mcdt_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(mcdt_agent_config)::get(this, "", "config", mcdt_agent_config_h))
      $fatal("Failed to get BFM");
    monitor = mcdt_monitor::type_id::create("monitor", this);
    mcdt_if = mcdt_agent_config_h.mcdt_if;
    uvm_config_db #(virtual mcdt_bfm)::set(this, "monitor", "config", mcdt_if);

  endfunction

  function void connect_phase(uvm_phase phase);

    
  endfunction

endclass