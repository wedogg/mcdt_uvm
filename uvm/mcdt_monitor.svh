class mcdt_monitor extends uvm_monitor;
  `uvm_component_utils(mcdt_monitor);

  uvm_blocking_put_port #(mon_data_t) mcdt_bp_port;

  virtual mcdt_bfm mcdt_if;

  function new (string name = "mcdt_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if (!uvm_config_db #(virtual mcdt_bfm)::get(this, "", "config", mcdt_if))
      $fatal("Failed to get BFM");
    mcdt_bp_port = new("mcdt_bp_port", this);
  endfunction

  task run_phase(uvm_phase phase);
    this.monitor_run();
  endtask

  task monitor_run();

    mon_data_t m;
    forever begin
      @(posedge mcdt_if.clk iff mcdt_if.mon_ck.mcdt_val==='b1);
      m.data = mcdt_if.mon_ck.mcdt_data;
      m.id = mcdt_if.mon_ck.mcdt_id;
      mcdt_bp_port.put(m);
      $display("%0t monitored mcdt data %8x and id %0d", $time, m.data, m.id);
    end

  endtask

endclass