main:   addi $2,$0,6    # $2=6
        ld   $3,66($2)  # $3 = 0xffffffff               3NOP
        lbu  $4,55($2)  # $4 = 2                        
        add  $5,$4,$3   # $5 = 0x1                      3NOP
        sb   $5,57($2)  # sb  [0x3f] = $5
        dadd  $6,$3,$4  # $6 = 0x100000001
        add  $7,$3,$4   # $7 = 0x1                      
        daddi $6,$6,13  # $6 = 0x10000000e              2NOP
        dsub  $8,$2,$3  # $8 = 0xffffffff00000007       
        sd   $6,66($2)  # sd  [0x48] = $6               2NOP
        sd   $8,82($2)  # sd  [0x58] = $8
        sd   $7,74($2)  # sd  [0x50] = $7
                        #                               10NOP