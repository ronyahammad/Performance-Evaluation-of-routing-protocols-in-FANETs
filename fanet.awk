BEGIN {
      printf "%6s ", p_nam  
      printf(" Date: %s",strftime("%c"))  
      printf ("\t %2d ", pause)  
      printf ("\t %2d ", speed)  
}

BEGIN {
    total_packets_sent = 0;
    total_packets_received = 0;
    total_packets_dropped = 0;
    total_end_to_end_delay = 0;
    total_throughput = 0;
    total_bytes_received = 0;
    total_bytes_dropped = 0;
    start_time = -1;
    end_time = -1;
}


($1 == "s" || $1 == "r" || $1 == "D") {
    total_packets_sent++;
    
    total_throughput += $8;
    
    if ($1 == "r") {
        end_to_end_delay = $2 - $3; 
        total_end_to_end_delay += end_to_end_delay;
        total_packets_received++;
        total_bytes_received += $8;
    }
    
    if ($1 == "D") {
        total_packets_dropped++;
        total_bytes_dropped += $8;
    }
    
    if (start_time == -1) {
        start_time = $2;
    }
    end_time = $2;
}

END {
    total_simulation_time = end_time - start_time;

    packet_delivery_ratio = (total_packets_received / total_packets_sent) * 100;

    if (total_packets_received > 0) {
        average_end_to_end_delay = total_end_to_end_delay / total_packets_received;
    } else {
        average_end_to_end_delay = 0;
    }

    print "Performance Metrics:";
    print "---------------------";
    printf "Packet Delivery Ratio: %.2f%%\n", packet_delivery_ratio;
    printf "Average End-to-End Delay: %.2f\n", average_end_to_end_delay;
    print "Total throughput (bytes/sec):" , total_throughput;
    print "Total packets sent:" , total_packets_sent;
    print "Total packets received:" , total_packets_received;
    print "Total packets dropped:" , total_packets_dropped;
    printf "Total simulation time: %.6f seconds\n", total_simulation_time;
    print "Total bytes received:", total_bytes_received;
    print "Total bytes dropped:", total_bytes_dropped;
}
