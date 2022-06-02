class chnl_monitor extends uvm_monitor;

  `uvm_component_utils(chnl_monitor);

  uvm_blocking_put_port #(mon_data_t) chnl_bp_port;
  uvm_analysis_port #(mon_data_t) chnl_cov_port;
  virtual chnl_bfm chnl_if;

  function new (string name = "chnl_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    
    if (!uvm_config_db #(virtual chnl_bfm)::get(this, "", "config", chnl_if))
      $fatal("Failed to get BFM");
    chnl_bp_port = new("chnl_bp_port", this);
    chnl_cov_port = new("chnl_cov_port", this);
  endfunction

  function void connect_phase(uvm_phase phase);
  endfunction


  task run_phase(uvm_phase phase);
    this.monitor_run();
  endtask

  task monitor_run();
    mon_data_t m;
    forever begin
      @(posedge chnl_if.clk iff(chnl_if.mon_ck.ch_valid==='b1 && chnl_if.mon_ck.ch_ready==='b1));
      m.data = chnl_if.mon_ck.ch_data;
      chnl_bp_port.put(m);
      chnl_cov_port.write(m);
      `uvm_info(get_type_name(), $sformatf("monitored channel data 'h%8x", m.data), UVM_HIGH)
    end
  endtask
endclass