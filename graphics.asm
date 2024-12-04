# MIPS Program: Drug Price Bar Chart
# Description: Displays a bar chart for selected drug prices across six countries using the MARS Bitmap Display.


.data
# Set display to:
# Pixels width and height to 4x4
# Display width and height to 512 x 256
# Base address = 0x10010000
# This will make our screen width 512/4 = 128 pixels (for width)
# and the screen height is 256/4 = 64 pixels (for height)
# 128 * 64 * 4 = 32,768 required bytes.


    # Screen information
    .eqv PIXEL_SIZE 4          	# Each pixel is 4 bytes 
    .eqv WIDTH 128              # Display width in pixels (512/4 = 128)
    .eqv HEIGHT 64              # Display height in pixels (256/4 = 64)
    .eqv DISPLAY 0x10010000     # Base address for Bitmap Display

    # Colors
    .eqv    RED     0x00FF0000  # Country 1 - US -> RED
    .eqv    GREEN   0x0034b818  # Country 2 - Canada -> GREEN
    .eqv    ORANGE  0x00e58e13  # Country 3 - Germany -> ORANGE
    .eqv    BLUE    0x002085d0  # Country 4 - UK -> BLUE
    .eqv    WHITE   0x00ffffff  # Country 5 - Brazil -> WHITE
    .eqv    YELLOW  0x00FFFF00  # Country 6 - Mexico -> YELLOW
    .eqv    BLACK   0x00000000  # Background color

    # Prompts and Messages
    select_prompt:   .asciiz "\nEnter the drug number to visualize (1-6): "
    invalid_input:   .asciiz "Invalid input. Please enter a number between 1 and 6.\n"
    header:          .asciiz "\nPrescription Cost Comparison:\n"


.text
.globl graphics

graphics:
 
    addi $sp, $sp, -4	        # make room for one word on the stack
    sw $ra, 0($sp)		# store return address
    move $fp, $sp		# set up frame pointer

    # Step 2: Display the selection prompt
    li $v0, 4                 # Syscall for print string
    la $a0, select_prompt     # Load address of prompt string
    syscall                   # Print prompt

    # Step 3: Read user input (integer)
    li $v0, 5                 # Syscall for read integer
    syscall                   # Read integer input
    
    li $t0, 1		# min value
    li $t1, 6		# max value
    
    # Step 4: Validate input (1-6)
    blt $v0, $t0, invalid_input_handler # If input < 1, invalid
    bgt $v0, $t1, invalid_input_handler # If input > 6, invalid


    # Step 5: Select the corresponding drug prices array
    beq $v0, 1, viagra_1
    beq $v0, 2, lipitor_2
    beq $v0, 3, ventolin_3
    beq $v0, 4, lantus_4
    beq $v0, 5, prozac_5
    beq $v0, 6, xanax_6

# Subroutines for each drug
viagra_1:


#Country 1: US -> RED  	
    li $t8, 4		# scaling factor 1/4
    div $t2, $t2, $t8
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 7          # Row (y-coordinate)
    li $a2, RED        # Color  
    move $a3, $t2      # move t2 to a3
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 8          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 9          # Row (y-coordinate)
    jal draw_row
    
# Country 2: Canada -> GREEN
    div $t3, $t3, $t8
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 16          # Row (y-coordinate)
    li $a2, GREEN        # Color 
    move $a3, $t3	# move t3 to a3
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 17          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 18          # Row (y-coordinate)
    jal draw_row    
    
# Country 3: Germany -> ORANGE
    div $t4, $t4, $t8
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 25          # Row (y-coordinate)
    li $a2, ORANGE        # Color 
    move $a3, $t4	# move t4 to a3
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 26          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 27          # Row (y-coordinate)
    jal draw_row        
    
# Country 4: UK -> BLUE
    div $t5, $t5, $t8
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 34          # Row (y-coordinate)
    li $a2, BLUE        # Color 
    move $a3, $t5	# move t5 to a3
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 35          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 36          # Row (y-coordinate)
    jal draw_row       
    
# Country 5: Brazil -> WHITE
    div $t6, $t6, $t8
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 43          # Row (y-coordinate)
    li $a2, WHITE        # Color 
    move $a3, $t6	# move t6 to a3
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 44          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 45          # Row (y-coordinate)
    jal draw_row      
    
# Country 6: Mexico -> YELLOW
    div $t7, $t7, $t8
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 52          # Row (y-coordinate)
    li $a2, YELLOW        # Color  
    move $a3, $t7	# move t7 to a3
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 53          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 54          # Row (y-coordinate)
    jal draw_row      

    jr $ra

lipitor_2:
#Country 1: US -> RED  
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 7          # Row (y-coordinate)
    li $a2, RED        # Color 
    move $a3, $t2	# move t2 to a3
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 8          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 9          # Row (y-coordinate)
    jal draw_row
    
# Country 2: Canada -> GREEN
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 16          # Row (y-coordinate)
    li $a2, GREEN        # Color 
    move $a3, $t3	# move t3 to a3
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 17          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 18          # Row (y-coordinate)
    jal draw_row    
    
# Country 3: Germany -> ORANGE
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 25          # Row (y-coordinate)
    li $a2, ORANGE        # Color  
    move $a3, $t4
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 26          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 27          # Row (y-coordinate)
    jal draw_row        
    
# Country 4: UK -> BLUE
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 34          # Row (y-coordinate)
    li $a2, BLUE        # Color  
    move $a3, $t5
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 35          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 36          # Row (y-coordinate)
    jal draw_row       
    
# Country 5: Brazil -> WHITE
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 43          # Row (y-coordinate)
    li $a2, WHITE        # Color  
    move $a3, $t6
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 44          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 45          # Row (y-coordinate)
    jal draw_row      
    
# Country 6: Mexico -> YELLOW
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 52          # Row (y-coordinate)
    li $a2, YELLOW        # Color  
    move $a3, $t7
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 53          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 54          # Row (y-coordinate)
    jal draw_row      

    jr $ra

ventolin_3:
# Country 1: US -> RED  
    li $t8, 35
    div $t2, $t2, $t8
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 7          # Row (y-coordinate)
    li $a2, RED        # Color  
    move $a3, $t2
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 8          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 9          # Row (y-coordinate)
    jal draw_row
    
# Country 2: Canada -> GREEN
    div $t3, $t3, $t8
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 16          # Row (y-coordinate)
    li $a2, GREEN        # Color  
    move $a3, $t3
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 17          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 18          # Row (y-coordinate)
    jal draw_row    
    
# Country 3: Germany -> ORANGE
    div $t4, $t4, $t8
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 25          # Row (y-coordinate)
    li $a2, ORANGE        # Color  
    move $a3, $t4
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 26          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 27          # Row (y-coordinate)
    jal draw_row        
    
# Country 4: UK -> BLUE
    div $t5, $t5, $t8
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 34          # Row (y-coordinate)
    li $a2, BLUE        # Color  
    move $a3, $t5
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 35          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 36          # Row (y-coordinate)
    jal draw_row       
    
# Country 5: Brazil -> WHITE
    div $t6, $t6, $t8
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 43          # Row (y-coordinate)
    li $a2, WHITE        # Color  
    move $a3, $t6
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 44          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 45          # Row (y-coordinate)
    jal draw_row      
    
# Country 6: Mexico -> YELLOW
    div $t7, $t7, $t8
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 52          # Row (y-coordinate)
    li $a2, YELLOW        # Color  
    move $a3, $t7
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 53          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 54          # Row (y-coordinate)
    jal draw_row      

    jr $ra

lantus_4:
#Country 1: US -> RED  
    li $t8, 50
    div $t2, $t2, $t8
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 7          # Row (y-coordinate)
    li $a2, RED        # Color  
    move $a3, $t2
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 8          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 9          # Row (y-coordinate)
    jal draw_row
    
# Country 2: Canada -> GREEN
    div $t3, $t3, $t8
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 16          # Row (y-coordinate)
    li $a2, GREEN        # Color  
    move $a3, $t3
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 17          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 18          # Row (y-coordinate)
    jal draw_row    
    
# Country 3: Germany -> ORANGE
    div $t4, $t4, $t8
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 25          # Row (y-coordinate)
    li $a2, ORANGE        # Color  
    move $a3, $t4
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 26          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 27          # Row (y-coordinate)
    jal draw_row        
    
# Country 4: UK -> BLUE
    div $t5, $t5, $t8
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 34          # Row (y-coordinate)
    li $a2, BLUE        # Color  
    move $a3, $t5
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 35          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 36          # Row (y-coordinate)
    jal draw_row       
    
# Country 5: Brazil -> WHITE
    div $t6, $t6, $t8
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 43          # Row (y-coordinate)
    li $a2, WHITE        # Color  
    move $a3, $t6
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 44          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 45          # Row (y-coordinate)
    jal draw_row      
    
# Country 6: Mexico -> YELLOW
    div $t7, $t7, $t8
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 52          # Row (y-coordinate)
    li $a2, YELLOW        # Color  
    move $a3, $t7
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 53          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 54          # Row (y-coordinate)
    jal draw_row      

    jr $ra

prozac_5:
#Country 1: US -> RED  
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 7          # Row (y-coordinate)
    li $a2, RED        # Color  
    move $a3, $t2
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 8          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 9          # Row (y-coordinate)
    jal draw_row
    
# Country 2: Canada -> GREEN
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 16          # Row (y-coordinate)
    li $a2, GREEN        # Color  
    move $a3, $t3
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 17          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 18          # Row (y-coordinate)
    jal draw_row    
    
# Country 3: Germany -> ORANGE
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 25          # Row (y-coordinate)
    li $a2, ORANGE        # Color  
    move $a3, $t4
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 26          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 27          # Row (y-coordinate)
    jal draw_row        
    
# Country 4: UK -> BLUE
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 34          # Row (y-coordinate)
    li $a2, BLUE        # Color  
    move $a3, $t5
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 35          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 36          # Row (y-coordinate)
    jal draw_row       
    
# Country 5: Brazil -> WHITE
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 43          # Row (y-coordinate)
    li $a2, WHITE
    move $a3, $t6
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 44          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 45          # Row (y-coordinate)
    jal draw_row      
    
# Country 6: Mexico -> YELLOW
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 52          # Row (y-coordinate)
    li $a2, YELLOW        # Color  
    move $a3, $t7
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 53          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 54          # Row (y-coordinate)
    jal draw_row      

    jr $ra

xanax_6:
#Country 1: US -> RED  
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 7          # Row (y-coordinate)
    li $a2, RED        # Color  
    move $a3, $t2
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 8          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 9          # Row (y-coordinate)
    jal draw_row
    
# Country 2: Canada -> GREEN
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 16          # Row (y-coordinate)
    li $a2, GREEN        # Color  
    move $a3, $t3
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 17          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 18          # Row (y-coordinate)
    jal draw_row    
    
# Country 3: Germany -> ORANGE
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 25          # Row (y-coordinate)
    li $a2, ORANGE        # Color  
    move $a3, $t4
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 26          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 27          # Row (y-coordinate)
    jal draw_row        
    
# Country 4: UK -> BLUE
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 34          # Row (y-coordinate)
    li $a2, BLUE        # Color  
    move $a3, $t5
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 35          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 36          # Row (y-coordinate)
    jal draw_row       
    
# Country 5: Brazil -> WHITE
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 43          # Row (y-coordinate)
    li $a2, WHITE        # Color  
    move $a3, $t6
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 44          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 45          # Row (y-coordinate)
    jal draw_row      
    
# Country 6: Mexico -> YELLOW
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 52          # Row (y-coordinate)
    li $a2, YELLOW        # Color  
    move $a3, $t7
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 53          # Row (y-coordinate)
    jal draw_row
    
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 54          # Row (y-coordinate)
    jal draw_row      

    lw $ra, 0($fp)
    jr $ra



# Function to draw a single pixel
# Pre-conditions:
#   $a0 = x-coordinate
#   $a1 = y-coordinate
#   $a2 = color
draw_pixel:
    mul $s1, $a1, WIDTH        # s1 = y * WIDTH
    add $s1, $s1, $a0          # s1 = x + (y * WIDTH)
    mul $s1, $s1, PIXEL_SIZE   # Convert to byte offset
    sw $a2, DISPLAY($s1)       # Store the color at the calculated address
    jr $ra

# Subroutine to draw a bar chart for a specific drug
# Pre-condition:
#   $t1 = address of the drug's prices array
draw_row:
    move $t0, $a0              # Current x-coordinate (start of the row)
    add $t1, $a0, $a3          # End x-coordinate (start + length)

    # Save $ra (return address) before entering the loop
    addiu $sp, $sp, -4         # Make space on the stack
    sw $ra, 0($sp)             # Save $ra to the stack

draw_row_loop:
    # Calculate and draw the current pixel
    move $a0, $t0              # x-coordinate
    jal draw_pixel             # Call draw_pixel

    addi $t0, $t0, 1           # Move to the next x-coordinate
    blt $t0, $t1, draw_row_loop # Repeat until the row is complete

    # Restore $ra (return address) after the loop
    lw $ra, 0($sp)             # Load $ra back from the stack
    addiu $sp, $sp, 4          # Restore stack pointer

    jr $ra                     # Return to caller

# Error Handler for Invalid Input
invalid_input_handler:
    li $v0, 4                 # Syscall for print string
    la $a0, invalid_input     # Load address of invalid input message
    syscall                   # Print error message
    j graphics                    # Restart the program



