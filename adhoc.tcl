set a 1
while {$a == 1 } {
puts "Enter the Routing Agents in FANET networking"
puts "1. AODV" 
puts "2. DSDV" 
puts "3. DSR" 
 
set top [gets stdin]
if {$top == 1} {
set opt(chan)           Channel/WirelessChannel    ;# channel type 
set opt(prop)           Propagation/TwoRayGround   ;# radio-propagation model 
set opt(netif)          Phy/WirelessPhy            ;# network interface type 
set opt(mac)            Mac/802_11                 ;# MAC type 
set opt(ifq)            Queue/DropTail/PriQueue    ;# interface queue type 
set opt(ll)             LL                         ;# link layer type 
set opt(ant)            Antenna/OmniAntenna        ;# antenna model 
set opt(ifqlen)         50                         ;# max packet in ifq 
set opt(nn)             24                         ;# number of mobilenodes 
set opt(rp)             AODV                       ;# routing protocol 
set opt(x)              1800   			   ;# X dimension of topography 
set opt(y)              840   			   ;# Y dimension of topography
set opt(z)              840   			   ;# Y dimension of topography   

### Setting The Simulator Objects
                  
      set ns_ [new Simulator]
#create the nam and trace file:
      set tracefd [open aodv.tr w]
      set windowVsTime [open aodvtr.tr w]
      $ns_ trace-all $tracefd

      set namtrace [open aodv.nam w]
      $ns_ namtrace-all-wireless $namtrace  $opt(x) $opt(y)

      set topo [new Topography]
      $topo load_flatgrid $opt(x) $opt(y)
      create-god $opt(nn)
      set chan_1_ [new $opt(chan)]
      
####  Setting The Distance Variables
                       

      # For model 'TwoRayGround'
      set dist(5m)  7.69113e-06
      set dist(9m)  2.37381e-06
      set dist(10m) 1.92278e-06
      set dist(11m) 1.58908e-06
      set dist(12m) 1.33527e-06
      set dist(13m) 1.13774e-06
      set dist(14m) 9.81011e-07
      set dist(15m) 8.54570e-07
      set dist(16m) 7.51087e-07
      set dist(20m) 4.80696e-07
      set dist(25m) 3.07645e-07
      set dist(30m) 2.13643e-07
      set dist(35m) 1.56962e-07
      set dist(40m) 1.56962e-10
      set dist(45m) 1.56962e-11
      set dist(50m) 1.20174e-13
      Phy/WirelessPhy set CSThresh_ $dist(50m)
      Phy/WirelessPhy set RXThresh_ $dist(50m)
      

#  Defining Node Configuration
                        
                  $ns_ node-config -adhocRouting $opt(rp) \
                   -llType $opt(ll) \
                   -macType $opt(mac) \
                   -ifqType $opt(ifq) \
                   -ifqLen $opt(ifqlen) \
                   -antType $opt(ant) \
                   -propType $opt(prop) \
                   -phyType $opt(netif) \
                   -topoInstance $topo \
                   -agentTrace ON \
                   -routerTrace ON \
                   -macTrace ON \
                   -movementTrace ON \
                   -channel $chan_1_

###  Creating The WIRELESS NODES
                  
      set Server1 [$ns_ node]
      set Server2 [$ns_ node]
      
	for {set i 2} {$i <= $opt(nn) } { incr i } {
	set n($i) [$ns_ node]
	$n($i) set X_ [ expr 10+round(rand()*1080) ]
 	$n($i) set Y_ [ expr 10+round(rand()*480) ]
 	$n($i) set Z_ 10.0
 	$ns_ at 0.75 "$n($i) setdest [ expr 100+round(rand()*1080) ] [ expr 10+round(rand()*180) ] 20.0"
 	$ns_ initial_node_pos $n($i) 70
 	$ns_ at 0.0 "$n($i) label node$i"
	}
	
      
      set opt(seed) 0.1
      set a [ns-random $opt(seed)]
      set i 0
      while {$i < 5} {
      incr i
      }
            

###  Setting The Initial Positions of Nodes

      $Server1 set X_ 213.0
      $Server1 set Y_ 517.0
      $Server1 set Z_ 10.0
      
      $Server2 set X_ 845.0
      $Server2 set Y_ 474.0
      $Server2 set Z_ 10.0
      
      
      
      ## Giving Mobility to Nodes
      
      for {set i 2} {$i <= $opt(nn) } { incr i } {
	#$ns_ at 0.50 "$n($i) setdest [ expr round(rand()*480) ] [ expr round(rand()*180) ] 20.0"
	$ns_ at 1.25 "$n($i) setdest [ expr round(rand()*1080) ] [ expr round(rand()*180) ] 25.0"
	}
            
      ## Setting The Node Size
                              
      $ns_ initial_node_pos $Server1 125
      $ns_ initial_node_pos $Server2 125
      
      

      #### Setting The Labels For Nodes
      
      $ns_ at 0.0 "$Server1 label Server1"
      $ns_ at 0.0 "$Server2 label Server2"
      
      

      $n(2) color green
      $ns_ at 0.0 "$n(2) color green"
      
      $n(3) color green
      $ns_ at 0.0 "$n(3) color green"
      
      $n(4) color green
      $ns_ at 0.0 "$n(4) color green"
      
      $n(5) color green
      $ns_ at 0.0 "$n(5) color green"
      
      $n(6) color green
      $ns_ at 0.0 "$n(6) color green"
      
      $n(7) color green
      $ns_ at 0.0 "$n(7) color green"
      
      $n(8) color green
      $ns_ at 0.0 "$n(8) color green"

      $n(9) color yellow
      $ns_ at 0.0 "$n(9) color yellow"
      
      $n(10) color yellow
      $ns_ at 0.0 "$n(10) color yellow"

      $n(11) color yellow
      $ns_ at 0.0 "$n(11) color yellow"
      
      $n(12) color pink
      $ns_ at 0.0 "$n(12) color pink"
      
      $n(13) color pink
      $ns_ at 0.0 "$n(13) color pink"

      $n(14) color pink
      $ns_ at 0.0 "$n(14) color pink"

      $n(15) color pink
      $ns_ at 0.0 "$n(15) color pink"

      $n(16) color pink
      $ns_ at 0.0 "$n(16) color pink"

      $n(17) color orange
      $ns_ at 0.0 "$n(17) color orange"

      $n(18) color orange
      $ns_ at 0.0 "$n(18) color orange"

      $n(19) color orange
      $ns_ at 0.0 "$n(19) color orange"

      $n(20) color orange
      $ns_ at 0.0 "$n(20) color orange"

      $n(21) color orange
      $ns_ at 0.0 "$n(21) color orange"

      $n(22) color orange
      $ns_ at 0.0 "$n(22) color orange"

      $Server1 color maroon
      $ns_ at 0.0 "$Server1 color maroon"
      
      $Server2 color maroon
      $ns_ at 0.0 "$Server2 color maroon"

      ## SETTING ANIMATION RATE 
$ns_ at 0.0 "$ns_ set-animation-rate 12.5ms"

   #  COLORING THE NODES  
$n(9) color blue
$ns_ at 4.71 "$n(9) color blue"
$n(5) color blue
$ns_ at 7.0 "$n(5) color blue"
$n(2) color blue
$ns_ at 7.29 "$n(2) color blue"

$n(16) color blue
$ns_ at 7.59 "$n(16) color blue"

$n(9) color maroon
$ns_ at 7.44 "$n(9) color maroon"

$ns_ at 7.43 "$n(9) label TTLover"
$ns_ at 7.55 "$n(9) label \"\""

$n(12) color blue
$ns_ at 7.85 "$n(12) color blue"
                  
####  Establishing Communication
	
      # Set a TCP connection between Server1 and node_(18)
      
      set tcp [new Agent/TCP/Reno]
      set sink [new Agent/TCPSink]
      set cbr [new Application/Traffic/CBR]
      $tcp set fid_ 1 
      $ns_ attach-agent $Server1 $tcp 
      $ns_ attach-agent $n(18) $sink 
      $ns_ connect $tcp $sink
      $cbr attach-agent $tcp
      $cbr set packetSize_ 1000    
      $cbr set interopt_ .07
      $ns_ at 0.0 "$cbr start"
      $ns_ at 4.0 "$cbr stop"
      
      # Set a TCP connection between Server1 and node_(22) 	
      set tcp [new Agent/TCP/Reno]
      set sink [new Agent/TCPSink]
      set cbr [new Application/Traffic/CBR]
      $tcp set fid_ 1
      $ns_ attach-agent $Server1 $tcp 
      $ns_ attach-agent $n(22) $sink 
      $ns_ connect $tcp $sink
      $cbr attach-agent $tcp
      $cbr set packetSize_ 1000    
      $cbr set interopt_ .07
      $ns_ at 0.1 "$cbr start"
      $ns_ at 4.1 "$cbr stop"

	# Set a TCP connection between node_(21) and node_(20)
	set tcp [new Agent/TCP/Reno]
      set sink [new Agent/TCPSink] 
      set cbr [new Application/Traffic/CBR]
      $tcp set fid_ 1
      $ns_ attach-agent $n(21) $tcp 
      $ns_ attach-agent $n(20) $sink 
      $ns_ connect $tcp $sink
      $cbr attach-agent $tcp
      $cbr set packetSize_ 1000    
      $cbr set interopt_ .07
      $ns_ at 2.4 "$cbr start"
      $ns_ at 4.1 "$cbr stop"
      
      # Set a TCP connection between Server1 and node_(15) 	
      set tcp [new Agent/TCP/Reno]
      set sink [new Agent/TCPSink]
      set cbr [new Application/Traffic/CBR]
      $tcp set fid_ 1 
      $ns_ attach-agent $Server1 $tcp 
      $ns_ attach-agent $n(15) $sink 
      $ns_ connect $tcp $sink
      $cbr attach-agent $tcp
      $cbr set packetSize_ 1000    
      $cbr set interopt_ 5
      $ns_ at 4.0 "$cbr start"
      $ns_ at 4.1 "$cbr stop"
      
	# Set a TCP connection between node_(15) and node_(16)
	set tcp [new Agent/TCP/Reno]
      set sink [new Agent/TCPSink]
      set cbr [new Application/Traffic/CBR]
      $tcp set fid_ 1 
      $ns_ attach-agent $n(15) $tcp 
      $ns_ attach-agent $n(16) $sink 
      $ns_ connect $tcp $sink
      $cbr attach-agent $tcp
      $cbr set packetSize_ 1000    
      $cbr set interopt_ 5
      $ns_ at 4.0 "$cbr start"
      $ns_ at 4.1 "$cbr stop"
      
      # Set a TCP connection between node_(15) and node_(17) 	
      set tcp [new Agent/TCP/Reno]
      set sink [new Agent/TCPSink]
      set cbr [new Application/Traffic/CBR]
      $tcp set fid_ 1 
      $ns_ attach-agent $n(15) $tcp 
      $ns_ attach-agent $n(17) $sink 
      $ns_ connect $tcp $sink
      $cbr attach-agent $tcp
      $cbr set packetSize_ 1000    
      $cbr set interopt_ 5
      $ns_ at 4.0 "$cbr start"
      $ns_ at 4.1 "$cbr stop"

	# Set a TCP connection between node_(14) and node_(4)
	set tcp [new Agent/TCP/Reno]
      set sink [new Agent/TCPSink]
      set cbr [new Application/Traffic/CBR]
      $tcp set fid_ 1 
      $ns_ attach-agent $n(14) $tcp 
      $ns_ attach-agent $n(4) $sink 
      $ns_ connect $tcp $sink
      $cbr attach-agent $tcp
      $cbr set packetSize_ 1000    
      $cbr set interopt_ 5
      $ns_ at 4.0 "$cbr start"
      $ns_ at 4.1 "$cbr stop"
      
      # Set a TCP connection between node_(14) and node_(9) 	
      set tcp [new Agent/TCP/Reno]
      set sink [new Agent/TCPSink]
      set cbr [new Application/Traffic/CBR]
      $tcp set fid_ 1 
      $ns_ attach-agent $n(14) $tcp 
      $ns_ attach-agent $n(19) $sink 
      $ns_ connect $tcp $sink
      $cbr attach-agent $tcp
      $cbr set packetSize_ 1000    
      $cbr set interopt_ 5
      $ns_ at 4.0 "$cbr start"
      $ns_ at 4.1 "$cbr stop"

	# Set a TCP connection between node_(4) and node_(3)
	set tcp [new Agent/TCP/Reno]
      set sink [new Agent/TCPSink]
      set cbr [new Application/Traffic/CBR]
      $tcp set fid_ 1 
      $ns_ attach-agent $n(4) $tcp 
      $ns_ attach-agent $n(3) $sink 
      $ns_ connect $tcp $sink
      $cbr attach-agent $tcp
      $cbr set packetSize_ 1000    
      $cbr set interopt_ 5
      $ns_ at 4.0 "$cbr start"
      $ns_ at 4.1 "$cbr stop"
      
      # Set a TCP connection between node_(4) and node_(2) 	
      set tcp [new Agent/TCP/Reno]
      set sink [new Agent/TCPSink]
      set cbr [new Application/Traffic/CBR]
      $tcp set fid_ 1 
      $ns_ attach-agent $n(4) $tcp 
      $ns_ attach-agent $n(2) $sink 
      $ns_ connect $tcp $sink
      $cbr attach-agent $tcp
      $cbr set packetSize_ 1000    
      $cbr set interopt_ 5
      $ns_ at 4.0 "$cbr start"
      $ns_ at 4.1 "$cbr stop"

	# Set a TCP connection between node_(9) and node_(16)
	set tcp [new Agent/TCP/Reno]
      set sink [new Agent/TCPSink]
      set cbr [new Application/Traffic/CBR]
      $tcp set fid_ 1 
      $ns_ attach-agent $n(9) $tcp 
      $ns_ attach-agent $n(16) $sink 
      $ns_ connect $tcp $sink
      $cbr attach-agent $tcp
      $cbr set packetSize_ 1000    
      $cbr set interopt_ 5
      $ns_ at 4.0 "$cbr start"
      $ns_ at 4.1 "$cbr stop"
      
      # Set a TCP connection between node_(9) and node_(10) 	
      set tcp [new Agent/TCP/Reno]
      set sink [new Agent/TCPSink]
      set cbr [new Application/Traffic/CBR]
      $tcp set fid_ 1 
      $ns_ attach-agent $n(9) $tcp 
      $ns_ attach-agent $n(10) $sink 
      $ns_ connect $tcp $sink
      $cbr attach-agent $tcp
      $cbr set packetSize_ 1000    
      $cbr set interopt_ 5
      $ns_ at 4.0 "$cbr start"
      $ns_ at 4.1 "$cbr stop"

      #ANNOTATIONS DETAILS 

      $ns_ at 0.0 "$ns_ trace-annotate \"MOBILE NODE MOVEMENTS\""
      $ns_ at 4.1 "$ns_ trace-annotate \"NODE27 CACHE THE DATA FRO SERVER\""
      #$ns_ at 4.59 "$ns_ trace-annotate \"PACKET LOSS AT NODE27\""     
      $ns_ at 4.71 "$ns_ trace-annotate \"NODE10 CACHE THE DATA\""      
            
      # Printing the window size
proc plotWindow {tcpSource file} {
global ns_
set time 0.01
set now [$ns_ now]
set cwnd [$tcpSource set cwnd_]
puts $file "$now $cwnd"
$ns_ at [expr $now+$time] "plotWindow $tcpSource $file" }
$ns_ at 10.1 "plotWindow $tcp $windowVsTime"
  
      
      ### PROCEDURE TO STOP 

      proc stop {} {
            
          	        global ns_ tracefd
                        $ns_ flush-trace
                        close $tracefd
                        exec nam aodv.nam &            
                        exit 0

                   }

      puts "Starting Simulation........"
      $ns_ at 25.0 "stop"
      $ns_ run
           
	
} elseif {$top == 2} {
# Define options 
set val(chan)           Channel/WirelessChannel    ;# channel type 
set val(prop)           Propagation/TwoRayGround   ;# radio-propagation model 
set val(netif)          Phy/WirelessPhy            ;# network interface type 
set val(mac)            Mac/802_11                 ;# MAC type 
set val(ifq)            Queue/DropTail/PriQueue    ;# interface queue type 
set val(ll)             LL                         ;# link layer type 
set val(ant)            Antenna/OmniAntenna        ;# antenna model 
set val(ifqlen)         50                         ;# max packet in ifq 
set val(nn)             24                          ;# number of mobilenodes 
set val(rp)             DSDV                       ;# routing protocol 
set val(x)              900   			   ;# X dimension of topography 
set val(y)              600   			   ;# Y dimension of topography   
set val(stop)		100			   ;# time of simulation end 

set ns_		  [new Simulator]

set tracefd       [open dsdv.tr w]
set windowVsTime [open dsdvtr.tr w] 
set namtrace      [open dsdv.nam w] 

$ns_ trace-all $tracefd 
$ns_ namtrace-all-wireless $namtrace $val(x) $val(y) 

Antenna/OmniAntenna set X_ 0
Antenna/OmniAntenna set Y_ 0
Antenna/OmniAntenna set Z_ 1.5
Antenna/OmniAntenna set Gt_ 1.0
Antenna/OmniAntenna set Gr_ 1.0

set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)
      


# configure the nodes 
$ns_ node-config -adhocRouting $val(rp) \
			 -llType $val(ll) \
			 -macType $val(mac) \
			 -ifqType $val(ifq) \
			 -ifqLen $val(ifqlen) \
			 -antType $val(ant) \
			 -propType $val(prop) \
			 -phyType $val(netif) \
			 -channelType $val(chan) \
			 -topoInstance $topo \
			 -energyModel "EnergyModel" \
			 -initialEnergy 50 \
			 -txPower 0.09 \
			 -rxPower 0.07 \
			 -idlePower 0.01 \
			 -sleeppower 0.0001 \
			 -transitionPower 0.02 \
                	 -transitionTime 0.0005 \
			 -agentTrace ON \
			 -routerTrace ON \
			 -macTrace OFF \
			 -movementTrace ON
	

###  Creating The WIRELESS NODES
                  
      set Server1 [$ns_ node]
      
      
	for {set i 1} {$i < $val(nn) } { incr i } {
	set n($i) [$ns_ node]
	$n($i) set X_ [ expr 100 + round(rand()*480) ]
 	$n($i) set Y_ [ expr 100 + round(rand()*380) ]
 	$n($i) set Z_ 10.0
 	$ns_ at 0.0 "$n($i) label node$i"
	}
	
      

###  Setting The Initial Positions of Nodes

      $Server1 set X_ 5.0
      $Server1 set Y_ 5.0
      $Server1 set Z_ 10.0
     	
     
      
###  generation of Server 1 mobility 
	   
      $ns_ at 5.0 "$Server1 setdest 600.0 500.0 6.0" 
      
	## Giving Mobility to Nodes
      for {set i 1} {$i < $val(nn) } { incr i } {
	$ns_ at 10.0 "$n($i) setdest [ expr 10 + round(rand()*45) ] [ expr 100+round(rand()*250) ] 10.0"
	#$ns_ at 15.0 "$n($i) setdest [ expr 100 + round(rand()*250) ] [ expr 100+round(rand()*30) ] 10.0"
	$ns_ at 30.0 "$n($i) setdest 180.0 [ expr 100+round(rand()*200) ] 10.0"
	$ns_ at 70.0 "$n($i) setdest [ expr 10 + round(rand()*98) ] [ expr 100+round(rand()*380) ] 10.0"
	$ns_ at 80.0 "$n($i) setdest 200 [ expr 100+round(rand()*200) ] 10.0"
	$ns_ at 90.0 "$n($i) setdest [ expr 10 + round(rand()*300) ] [ expr 100+round(rand()*250) ] 10.0"
	}
      
            
      ## Setting The Node Size
                              
      $ns_ initial_node_pos $Server1 125
      
      

      #### Setting The Labels For Nodes
      
      $ns_ at 0.0 "$Server1 label Server1"
      

      $n(2) color green
      $ns_ at 0.0 "$n(2) color green"
      
      $n(3) color green
      $ns_ at 0.0 "$n(3) color green"
      
      $n(4) color green
      $ns_ at 0.0 "$n(4) color green"
      
      $n(5) color green
      $ns_ at 0.0 "$n(5) color green"
      
      $n(6) color green
      $ns_ at 0.0 "$n(6) color green"
      
      $n(7) color green
      $ns_ at 0.0 "$n(7) color green"
      
      $n(8) color green
      $ns_ at 0.0 "$n(8) color green"

      $n(9) color yellow
      $ns_ at 0.0 "$n(9) color yellow"
      
      $n(10) color yellow
      $ns_ at 0.0 "$n(10) color yellow"

      $n(11) color yellow
      $ns_ at 0.0 "$n(11) color yellow"
      
      $n(12) color pink
      $ns_ at 0.0 "$n(12) color pink"
      
      $n(13) color pink
      $ns_ at 0.0 "$n(13) color pink"

      $n(14) color pink
      $ns_ at 0.0 "$n(14) color pink"

      $n(15) color pink
      $ns_ at 0.0 "$n(15) color pink"

      $n(16) color pink
      $ns_ at 0.0 "$n(16) color pink"

      $n(17) color orange
      $ns_ at 0.0 "$n(17) color orange"

      $n(18) color orange
      $ns_ at 0.0 "$n(18) color orange"

      $n(19) color orange
      $ns_ at 0.0 "$n(19) color orange"

      $n(20) color orange
      $ns_ at 0.0 "$n(20) color orange"

      $n(21) color orange
      $ns_ at 0.0 "$n(21) color orange"

      $n(22) color orange
      $ns_ at 0.0 "$n(22) color orange"


      $Server1 color maroon
      $ns_ at 0.0 "$Server1 color maroon"
      
      

      ## SETTING ANIMATION RATE 
$ns_ at 0.0 "$ns_ set-animation-rate 12.5ms"

   #  COLORING THE NODES  
$n(9) color blue
$ns_ at 4.71 "$n(9) color blue"
$n(5) color blue
$ns_ at 7.0 "$n(5) color blue"
$n(2) color blue
$ns_ at 7.29 "$n(2) color blue"

$n(16) color blue
$ns_ at 7.59 "$n(16) color blue"

$n(9) color maroon
$ns_ at 7.44 "$n(9) color maroon"

$ns_ at 7.43 "$n(9) label TTLover"
$ns_ at 7.55 "$n(9) label \"\""

$n(12) color blue
$ns_ at 7.85 "$n(12) color blue"

# Set a TCP connection between server1 and all the nodes 

for {set i 1} {$i < $val(nn) } { incr i } {
set tcp [new Agent/TCP/Reno]
set sink [new Agent/TCPSink] 
set cbr [new Application/Traffic/CBR] 
$ns_ attach-agent $Server1 $tcp
$ns_ attach-agent $n($i) $sink
$ns_ connect $tcp $sink
$cbr attach-agent $tcp
$cbr set packetSize_ 1000
$cbr set rate_ 1.0Mb
$cbr set random_ null
$ns_ at 1.0 "$cbr start"
}
 
# Define node initial position in nam 
for {set i 1} {$i < $val(nn)} { incr i } { 
# 30 defines the node size for nam 
$ns_ initial_node_pos $n($i) 30 
} 
 
# Telling nodes when the simulation ends 
for {set i 1} {$i < $val(nn) } { incr i } { 
    $ns_ at $val(stop) "$n($i) reset"; 
}

# ending nam and the simulation  
$ns_ at $val(stop) "$ns_ nam-end-wireless $val(stop)" 
$ns_ at $val(stop) "stop" 
$ns_ at 150.01 "puts \"end simulation\" ; $ns_ halt" 

# Printing the window size
proc plotWindow {tcpSource file} {
global ns_
set time 0.01
set now [$ns_ now]
set cwnd [$tcpSource set cwnd_]
puts $file "$now $cwnd"
$ns_ at [expr $now+$time] "plotWindow $tcpSource $file" }
$ns_ at 10.1 "plotWindow $tcp $windowVsTime"

proc stop {} { 
    global ns_ tracefd namtrace 
    $ns_ flush-trace 
    close $tracefd 
    close $namtrace 
    #Execute nam on the trace file 
    exec nam dsdv.nam & 
    exit 0 
} 
puts "Starting Simulation........"
$ns_ run
	
} elseif {$top == 3} {
set val(chan)           Channel/WirelessChannel    ;# channel type 
set val(prop)           Propagation/Nakagami   ;# radio-propagation model 
set val(netif)          Phy/WirelessPhy            ;# network interface type 
set val(mac)            Mac/802_11                 ;# MAC type 
set val(ifq)            CMUPriQueue    ;# interface queue type 
set val(ll)             LL                         ;# link layer type 
set val(ant)            Antenna/OmniAntenna        ;# antenna model 
set val(ifqlen)         50                         ;# max packet in ifq 
set val(nn)             24                          ;# number of mobilenodes 
set val(rp)             DSR                       ;# routing protocol 
set val(x)              500   			   ;# X dimension of topography 
set val(y)              400   			   ;# Y dimension of topography
set val(z)          	500   		   ;# Z dimension of the topography     
set val(stop)		150			   ;# time of simulation end 



set ns_		  [new Simulator]

set tracefd       [open dsr.tr w]
set namtrace      [open dsr.nam w] 

$ns_ trace-all $tracefd 
$ns_ namtrace-all-wireless $namtrace $val(x) $val(y) 


set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)
set god_ [create-god $val(nn)]

set chan [new $val(chan)]


# configure the nodes 
$ns_ node-config -adhocRouting $val(rp) \
                   -llType $val(ll) \
                   -macType $val(mac) \
                   -ifqType $val(ifq) \
                   -ifqLen $val(ifqlen) \
                   -antType $val(ant) \
                   -propType $val(prop) \
                   -phyType $val(netif) \
                   -channelType $val(chan) \
                   -topoInstance $topo \
                   -agentTrace ON \
                   -routerTrace ON \
                   -macTrace OFF \
                   -movementTrace ON
                   
                   
###  Creating The WIRELESS NODES
                  
      set Server1 [$ns_ node]
      set Server2 [$ns_ node]
      
	for {set i 2} {$i < $val(nn) } { incr i } {
	set n($i) [$ns_ node]
	$n($i) set X_ [ expr 100+round(rand()*150) ]
 	$n($i) set Y_ [ expr 10+round(rand()*240) ]
 	$n($i) set Z_ 10.0
 	$ns_ at 0.0 "$n($i) label node$i"
	}
	
      
      
###  Setting The Initial Positions of Nodes

      $Server1 set X_ 5.0
      $Server1 set Y_ 5.0
      $Server1 set Z_ 10.0
      
      $Server2 set X_ 490.0
      $Server2 set Y_ 285.0
      $Server2 set Z_ 10.0
      
## Giving Mobility to Nodes
$ns_ at 10.0 " $Server1 setdest 250.0 250.0 3.0"
$ns_ at 15.0 " $Server2 setdest 45.0 280.0 5.0"
$ns_ at 110.0 "$Server1 setdest 480.0 300.0 5.0" 



      
## Setting The Node Size
                              
      $ns_ initial_node_pos $Server1 30
      $ns_ initial_node_pos $Server2 30
      
      

      #### Setting The Labels For Nodes
      
      $ns_ at 0.0 "$Server1 label Server1"
      $ns_ at 0.0 "$Server2 label Server2"
      
      

      $n(2) color green
      $ns_ at 0.0 "$n(2) color green"
      
      $n(3) color green
      $ns_ at 0.0 "$n(3) color green"
      
      $n(4) color green
      $ns_ at 0.0 "$n(4) color green"
      
      $n(5) color green
      $ns_ at 0.0 "$n(5) color green"
      
      $n(6) color green
      $ns_ at 0.0 "$n(6) color green"
      
      $n(7) color green
      $ns_ at 0.0 "$n(7) color green"
      
      $n(8) color green
      $ns_ at 0.0 "$n(8) color green"

      $n(9) color yellow
      $ns_ at 0.0 "$n(9) color yellow"
      
      $n(10) color yellow
      $ns_ at 0.0 "$n(10) color yellow"

      $n(11) color yellow
      $ns_ at 0.0 "$n(11) color yellow"
      
      $n(12) color pink
      $ns_ at 0.0 "$n(12) color pink"
      
      $n(13) color pink
      $ns_ at 0.0 "$n(13) color pink"

      $n(14) color pink
      $ns_ at 0.0 "$n(14) color pink"

      $n(15) color pink
      $ns_ at 0.0 "$n(15) color pink"

      $n(16) color pink
      $ns_ at 0.0 "$n(16) color pink"

      $n(17) color orange
      $ns_ at 0.0 "$n(17) color orange"

      $n(18) color orange
      $ns_ at 0.0 "$n(18) color orange"

      $n(19) color orange
      $ns_ at 0.0 "$n(19) color orange"

      $n(20) color orange
      $ns_ at 0.0 "$n(20) color orange"

      $n(21) color orange
      $ns_ at 0.0 "$n(21) color orange"

      $n(22) color orange
      $ns_ at 0.0 "$n(22) color orange"

      $Server1 color maroon
      $ns_ at 0.0 "$Server1 color maroon"
      
      $Server2 color maroon
      $ns_ at 0.0 "$Server2 color maroon"

      ## SETTING ANIMATION RATE 
$ns_ at 0.0 "$ns_ set-animation-rate 12.5ms"

   #  COLORING THE NODES  
$n(9) color blue
$ns_ at 4.71 "$n(9) color blue"
$n(5) color blue
$ns_ at 7.0 "$n(5) color blue"
$n(2) color blue
$ns_ at 7.29 "$n(2) color blue"

$n(16) color blue
$ns_ at 7.59 "$n(16) color blue"

$n(9) color maroon
$ns_ at 7.44 "$n(9) color maroon"

$ns_ at 7.43 "$n(9) label TTLover"
$ns_ at 7.55 "$n(9) label \"\""

$n(12) color blue
$ns_ at 7.85 "$n(12) color blue"

# Set a TCP connection between server 1 and server 2
set tcp [new Agent/TCP/Reno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
#set cbr [new Application/Traffic/CBR]
$ns_ attach-agent $Server1 $tcp 
$ns_ attach-agent $Server2 $sink 
$ns_ connect $tcp $sink
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $tcp
$cbr set packetSize_ 1000    
$cbr set interopt_ .07
$ns_ at 10.0 "$cbr start"

# Define node initial position in nam 
for {set i 2} {$i <$val(nn)} { incr i } { 
# 30 defines the node size for nam 
$ns_ initial_node_pos $n($i) 30 
} 
 
# Telling nodes when the simulation ends 
for {set i 2} {$i < $val(nn) } { incr i } { 
    $ns_ at $val(stop) "$n($i) reset"; 
}

      
# ending nam and the simulation  
$ns_ at $val(stop) "$ns_ nam-end-wireless $val(stop)" 
$ns_ at $val(stop) "stop" 
$ns_ at 150.01 "puts \"end simulation\" ; $ns_ halt"



proc stop {} { 
    global ns_ tracefd namtrace 
    $ns_ flush-trace 
    close $tracefd 
    close $namtrace 
    #Execute nam on the trace file 
    exec nam dsr.nam & 
    exit 0 
} 
puts "Starting Simulation........"
$ns_ run	

	
} 
puts "want to continue (0/1)" 
set a [gets stdin]
}