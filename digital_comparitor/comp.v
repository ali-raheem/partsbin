/*
   Copyright 2018 Ali Raheem <ali.raheem@gmail.com>

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and limitations under the License.
*/

module comp (a, b, gt, eq, lt);
   parameter WIDTH = 4;
   input [WIDTH-1:0] a;
   input [WIDTH-1:0] b;
   output 	     gt;
   output 	     eq;
   output 	     lt;

   assign gt = a > b;
   assign eq = a == b;
   assign lt = a < b;
endmodule // comp
