class my_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(my_scoreboard);
  `uvm_blocking_put_imp_decl(_chnl0)
  `uvm_blocking_put_imp_decl(_chnl1)
  `uvm_blocking_put_imp_decl(_chnl2)
  `uvm_blocking_put_imp_decl(_mcdth)
  local int err_count;
  local int total_count;

  mailbox #(mon_data_t) chnl_mbs[3];
  mailbox #(mon_data_t) mcdt_mbs;

  uvm_blocking_put_imp_chnl0 #(mon_data_t, my_scoreboard) chnl_0_bp_imp;
  uvm_blocking_put_imp_chnl1 #(mon_data_t, my_scoreboard) chnl_1_bp_imp;
  uvm_blocking_put_imp_chnl2 #(mon_data_t, my_scoreboard) chnl_2_bp_imp;
  uvm_blocking_put_imp_mcdth #(mon_data_t, my_scoreboard) mcdt_bp_imp;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    this.err_count = 0;
    this.total_count = 0;

  endfunction


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    chnl_0_bp_imp = new("chnl_0_bp_imp", this);
    chnl_1_bp_imp = new("chnl_1_bp_imp", this);
    chnl_2_bp_imp = new("chnl_2_bp_imp", this);
    mcdt_bp_imp = new("mcdt_bp_imp", this);
    foreach(this.chnl_mbs[i]) this.chnl_mbs[i] = new();
    this.mcdt_mbs = new();
  endfunction

  task run_phase(uvm_phase phase);
    do_result_compare();
  endtask

  task do_result_compare();
    mon_data_t expected, result;
    forever begin
    mcdt_mbs.get(result);
    this.total_count++;
    case(result.id)
    0:  chnl_mbs[0].get(expected);
    1:  chnl_mbs[1].get(expected);
    2:  chnl_mbs[2].get(expected);
    endcase
    if (result.data != expected.data) begin
      this.err_count++;
      `uvm_error("[CMPERR]", $sformatf("%0dth times comparing but failed! MCDF monitored output packet is different with reference model output", this.total_count))
    end
    else begin
      `uvm_info("[CMPSUC]",$sformatf("%0dth times comparing and succeeded! MCDF monitored output packet is the same with reference model output", this.total_count), UVM_LOW)
    end
    end
  endtask

  task put_mcdth(mon_data_t t);
    mcdt_mbs.put(t);
  endtask

  task put_chnl0(mon_data_t t);
    chnl_mbs[0].put(t);
  endtask
  task put_chnl1(mon_data_t t);
    chnl_mbs[1].put(t);
  endtask
  task put_chnl2(mon_data_t t);
    chnl_mbs[2].put(t);
  endtask

  function void write(mon_data_t t);
  endfunction
endclass