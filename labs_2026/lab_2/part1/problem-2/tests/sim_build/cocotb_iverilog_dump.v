module cocotb_iverilog_dump();
initial begin
    string dumpfile_path;    if ($value$plusargs("dumpfile_path=%s", dumpfile_path)) begin
        $dumpfile(dumpfile_path);
    end else begin
        $dumpfile("/home/hextex/Documents/GitHub/Chula_Coursework/Year_2/Sem_2/2110363-HW-SYN-LAB/labs_2026/lab_2/part1/problem-2/tests/sim_build/bcd_counter.fst");
    end
    $dumpvars(0, bcd_counter);
end
endmodule
