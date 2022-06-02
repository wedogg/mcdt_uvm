class chnl_sequence extends uvm_sequence #(chnl_sequence_item);
  `uvm_object_utils(chnl_sequence);
  
  chnl_sequencer sequencer_h;
  uvm_component uvm_component_h;

  function new(string name = "chnl_sequence");
    super.new(name);
  endfunction //new()

  int pkt_id = 0;
  int ch_id;
  int data_nidles = 4;
  int pkt_nidles = 4;
  int data_size = 2;
  int ntrans = 100;

  task body();
    repeat(ntrans) send_trans();
  endtask

  task send_trans();
    chnl_sequence_item req;
    chnl_sequence_item rsp;
    req = chnl_sequence_item::type_id::create("req");
    wait_for_grant();
    assert(req.randomize with {local::ch_id >= 0 -> ch_id == local::ch_id; 
                       local::pkt_id >= 0 -> pkt_id == local::pkt_id;
                       local::data_nidles >= 0 -> data_nidles == local::data_nidles;
                       local::pkt_nidles >= 0 -> pkt_nidles == local::pkt_nidles;
                       local::data_size >0 -> data.size() == local::data_size; 
                       }); 
    post_randomize();
    send_request(req);
    wait_for_item_done();
    get_response(rsp);        

    this.pkt_id++;
  endtask

  function string sprint();
    string s;
    s = {s, $sformatf("=======================================\n")};
    s = {s, $sformatf("chnl_sequence object content is as below: \n")};
    s = {s, $sformatf("ntrans = %0d: \n", this.ntrans)};
    s = {s, $sformatf("ch_id = %0d: \n", this.ch_id)};
    s = {s, $sformatf("pkt_id = %0d: \n", this.pkt_id)};
    s = {s, $sformatf("data_nidles = %0d: \n", this.data_nidles)};
    s = {s, $sformatf("pkt_nidles = %0d: \n", this.pkt_nidles)};
    s = {s, $sformatf("data_size = %0d: \n", this.data_size)};
    s = {s, $sformatf("=======================================\n")};
    return(s);
  endfunction

  function void post_randomize();
    string s;
    s = {"AFTER RANDOMIZATION \n", this.sprint()};
    $display(s);
  endfunction

endclass