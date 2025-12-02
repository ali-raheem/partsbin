/*
   Copyright 2024, 2025 Ali Raheem <ali.raheem@gmail.com>

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and limitations under the License.
*/

module HC1645 (
    input wire clk,
    input wire clk_inh,
    input wire shld,
    input wire rst,
    input wire [7:0] data_in,
    input wire shift_in,
    output wire q,
    output wire q_n
);
    reg [7:0] shift_reg = 8'b0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            shift_reg <= 8'b0;
        end else if (!clk_inh) begin
            if (!shld) begin
                shift_reg <= data_in;
            end else begin
                shift_reg <= {shift_reg[6:0], shift_in};
            end
        end
    end

    assign q = shift_reg[7];
    assign q_n = ~shift_reg[7];

endmodule // HC1645
