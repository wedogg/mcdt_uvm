class chnl_driver extends uvm_driver #(chnl_sequence_item);
  `uvm_component_utils(chnl_driver);

  virtual chnl_bfm chnl_if;

  function new(string name = "chnl_driver", uvm_component parent);
    super.new(name, parent);
  endfunction //new()

  function void build_phase(uvm_phase phase);
    
    if (!uvm_config_db #(virtual chnl_bfm)::get(this, "", "config", chnl_if))
      $fatal("Failed to get BFM");
  endfunction

  task run_phase(uvm_phase phase);
    
    this.drive();  
    
  endtask

  task drive();
    chnl_sequence_item req, rsp;
    @(posedge chnl_if.rstn);
    forever begin
      seq_item_port.get_next_item(req);
      this.chnl_write(req);
      void'($cast(rsp, req.clone()));
      rsp.rsp = 1;
      rsp.set_sequence_id(req.get_sequence_id());
      seq_item_port.put(rsp);
      seq_item_port.item_done();
    end    
  endtask

  task chnl_write(input chnl_sequence_item t);
    foreach(t.data[i]) begin
      @(posedge chnl_if.clk);
      chnl_if.drv_ck.ch_valid <= 1;
      chnl_if.drv_ck.ch_data <= t.data[i];
      @(negedge chnl_if.clk);
      wait(chnl_if.ch_ready === 'b1);
      `uvm_info(get_type_name(), $sformatf("sent data 'h%8x", t.data[i]), UVM_HIGH)
      repeat(t.data_nidles) chnl_idle();
    end
    repeat(t.pkt_nidles) chnl_idle();
  endtask
    
  task chnl_idle();
    @(posedge chnl_if.clk);
    chnl_if.drv_ck.ch_valid <= 0;
    chnl_if.drv_ck.ch_data <= 0;
  endtask

endclass