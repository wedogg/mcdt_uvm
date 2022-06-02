class env extends uvm_env;
  `uvm_component_utils(env);

  chnl_agent chnl_agent_0, chnl_agent_1, chnl_agent_2;
  mcdt_agent mcdt_agent_h;
  chnl_agent_config chnl_config_0, chnl_config_1, chnl_config_2;
  mcdt_agent_config mcdt_config_h;
  my_scoreboard my_scoreboard_h;
  my_coverage my_coverage_h;

  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    virtual chnl_bfm chnl0_if, chnl1_if, chnl2_if;
    virtual mcdt_bfm mcdt_if;
    env_config env_config_h;

    if(!uvm_config_db #(env_config)::get(this, "", "config", env_config_h))
      `uvm_fatal("RANDOM TEST", "Faild to get class bfm");

    chnl_config_0 = new(.chnl_if(env_config_h.chnl0_if));
    chnl_config_1 = new(.chnl_if(env_config_h.chnl1_if));
    chnl_config_2 = new(.chnl_if(env_config_h.chnl2_if));
    mcdt_config_h = new(.mcdt_if(env_config_h.mcdt_if));
    
    uvm_config_db #(chnl_agent_config)::set(this, "chnl_agent_0*", "config", chnl_config_0);
    uvm_config_db #(chnl_agent_config)::set(this, "chnl_agent_1*", "config", chnl_config_1);
    uvm_config_db #(chnl_agent_config)::set(this, "chnl_agent_2*", "config", chnl_config_2);
    uvm_config_db #(mcdt_agent_config)::set(this, "mcdt_agent_h*", "config", mcdt_config_h);


    chnl_agent_0 = chnl_agent::type_id::create("chnl_agent_0", this);
    chnl_agent_1 = chnl_agent::type_id::create("chnl_agent_1", this);
    chnl_agent_2 = chnl_agent::type_id::create("chnl_agent_2", this);
    mcdt_agent_h = mcdt_agent::type_id::create("mcdt_agent_h", this);
    my_scoreboard_h = my_scoreboard::type_id::create("my_scoreboard_h", this);
    my_coverage_h = my_coverage::type_id::create("my_coverage_h", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    mcdt_agent_h.monitor.mcdt_bp_port.connect(my_scoreboard_h.mcdt_bp_imp);
    chnl_agent_0.monitor_h.chnl_bp_port.connect(my_scoreboard_h.chnl_0_bp_imp);
    chnl_agent_1.monitor_h.chnl_bp_port.connect(my_scoreboard_h.chnl_1_bp_imp);
    chnl_agent_2.monitor_h.chnl_bp_port.connect(my_scoreboard_h.chnl_2_bp_imp);

    chnl_agent_0.monitor_h.chnl_cov_port.connect(my_coverage_h.chnl_0_cov_imp);
    chnl_agent_1.monitor_h.chnl_cov_port.connect(my_coverage_h.chnl_1_cov_imp);
    chnl_agent_2.monitor_h.chnl_cov_port.connect(my_coverage_h.chnl_2_cov_imp);
  endfunction
endclass