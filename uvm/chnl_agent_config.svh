class chnl_agent_config;

  virtual chnl_bfm chnl_if;
  
  function new (virtual chnl_bfm chnl_if);
    this.chnl_if = chnl_if;
  endfunction

endclass