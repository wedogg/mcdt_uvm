class env_config;
  virtual chnl_bfm chnl0_if, chnl1_if, chnl2_if;
  virtual mcdt_bfm mcdt_if;

  function new(virtual chnl_bfm chnl0_if, virtual chnl_bfm chnl1_if, virtual chnl_bfm chnl2_if, virtual mcdt_bfm mcdt_if);
    this.chnl0_if = chnl0_if;
    this.chnl1_if = chnl1_if;
    this.chnl2_if = chnl2_if;
    this.mcdt_if = mcdt_if;
  endfunction : new

endclass