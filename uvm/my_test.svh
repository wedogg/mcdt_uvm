class my_test extends uvm_test;

  `uvm_component_utils(my_test);

  env env_h;
  env_config env_config_h;
  chnl_sequence sequence_0, sequence_1, sequence_2;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);

    virtual chnl_bfm chnl0_if, chnl1_if, chnl2_if;
    virtual mcdt_bfm mcdt_if;
//    env_config env_config_h;

    if(!uvm_config_db #(virtual chnl_bfm)::get(this, "", "chnl0_bfm", chnl0_if))
      `uvm_fatal("RANDOM TEST", "faild to get bfm")
    if(!uvm_config_db #(virtual chnl_bfm)::get(this, "", "chnl1_bfm", chnl1_if))
      `uvm_fatal("RANDOM TEST", "faild to get bfm")
    if(!uvm_config_db #(virtual chnl_bfm)::get(this, "", "chnl2_bfm", chnl2_if))
      `uvm_fatal("RANDOM TEST", "faild to get bfm")
    if(!uvm_config_db #(virtual mcdt_bfm)::get(this, "", "mcdt_bfm", mcdt_if))
      `uvm_fatal("RANDOM TEST", "faild to get bfm")

    env_config_h = new(.chnl0_if(chnl0_if), .chnl1_if(chnl1_if), .chnl2_if(chnl2_if), .mcdt_if(mcdt_if));
    env_h = env::type_id::create("env_h", this);
    uvm_config_db #(env_config)::set(this, "env_h*", "config", env_config_h);


    sequence_0 = chnl_sequence::type_id::create("sequence_0");
    sequence_1 = chnl_sequence::type_id::create("sequence_1");
    sequence_2 = chnl_sequence::type_id::create("sequence_2");
    sequence_0.ch_id = 0;
    sequence_1.ch_id = 1;
    sequence_2.ch_id = 2;
    
  endfunction : build_phase

  task run_phase(uvm_phase phase);

    phase.raise_objection(this);
    fork
    sequence_0.start(env_h.chnl_agent_0.sequencer_h);
    sequence_1.start(env_h.chnl_agent_1.sequencer_h);
    sequence_2.start(env_h.chnl_agent_2.sequencer_h);
    join
    phase.drop_objection(this);
  endtask
endclass