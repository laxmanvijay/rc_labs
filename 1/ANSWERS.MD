# Task 2.5 Synthesis

#### How many LUTs (total) are available on the FPGA? 
63400
#### How many LUTs did you use as logic?
1
#### How many LUTs did you use as memory? 
0
#### Is the resource utilization after synthesis accurate? 
No. Sythesis maps RTL to FPGA resources and provides an estimate but implementation (placement/routing) can alter the required resources.
#### How many DSPs are available on the FPGA 
240


#### What is the worst negative slack in your design? 
8.621ns
#### What is the worst hold slack in your design? 
0.132ns

# Task 2.6 Implementation

#### What is the worst negative slack in your design? 
8.756ns
#### What is the worst hold slack in your design? 
0.198ns

#### Compare the slack values to the results from synthesis. Are the values equal to the results from synthesis? If yes, why? If no, why?

No. Synthesis timing is only an estimate based on expected routing. Implementation timing is the authoritative one since it calculates post routing and takes into account the exact physical distances.

# Task 2.7 Custom placement and routing

#### What is the delay you can focus on to destroy the timing? 

Focus on the critical path interconnect delay. 

# Modify the placement

#### What are you effectively modifying when you modify the placement? 

Change the physical locations of logic cells on the FPGA which increases/decreases physical routing distances and resource used but not the logic.

# Modify the routing

#### What is the worst negative slack in your design? 
8.756ns
#### What is the worst hold slack in your design? 
0.198ns
