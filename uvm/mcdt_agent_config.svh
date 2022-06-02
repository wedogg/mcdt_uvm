class mcdt_agent_config;

  virtual mcdt_bfm mcdt_if;

  function new (virtual mcdt_bfm mcdt_if);
    this.mcdt_if = mcdt_if;
  endfunction

endclass