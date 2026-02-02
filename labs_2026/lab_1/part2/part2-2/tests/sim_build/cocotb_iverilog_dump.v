module cocotb_iverilog_dump();
initial begin
    string dumpfile_path;    if ($value$plusargs("dumpfile_path=%s", dumpfile_path)) begin
        $dumpfile(dumpfile_path);
    end else begin
        $dumpfile("/home/hextex/Documents/GitHub/Chula_Coursework/Year_2/Sem_2/2110363-HW-SYN-LAB/labs_2026/lab_1/part2/part2-2/tests/sim_build/full_adder_4_bit.fst");
    end
    $dumpvars(0, full_adder_4_bit);
end
endmodule
