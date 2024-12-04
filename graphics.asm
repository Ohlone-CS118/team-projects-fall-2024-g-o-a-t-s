# MIPS Program: Drug Price Bar Chart
# Description: Displays a bar chart for selected drug prices across six countries using the MARS Bitmap Display.


.data
# Set display to:
# Pixels width and height to 4x4
# Display width and height to 512 x 512
# Base address = 0x10010000
# This will make our screen width 128x128 (512/4 = 128)
# 128 * 128 * 4 = 65,536 required bytes.

    # Screen information
    .eqv PIXEL_SIZE 4          	# Each pixel is 4 bytes (ARGB format)
    .eqv WIDTH 128              # Display width in pixels
    .eqv HEIGHT 128             # Display height in pixels
    .eqv DISPLAY 0x10010000     # Base address for Bitmap Display

    # Colors
    .eqv    RED     0x00FF0000  # Country 1
    .eqv    GREEN   0x0034b818  # Country 2
    .eqv    ORANGE  0x00e58e13  # Country 3
    .eqv    BLUE    0x002085d0  # Country 4
    .eqv    WHITE   0x00ffffff  # Country 5
    .eqv    YELLOW  0x00FFFF00  # Country 6
    .eqv    BLACK   0x00000000  # Background color

    # Prompts and Messages
    select_prompt:   .asciiz "\nEnter the drug number to visualize (1-6): "
    invalid_input:   .asciiz "Invalid input. Please enter a number between 1 and 6.\n"
    header:          .asciiz "\nPrescription Cost Comparison:\n"

    # Drug Prices (Scaled by 100 to handle decimal values)
    # Each drug has six prices corresponding to six countries
    # Format: Drug1: Country1, Country2, ..., Country6
    viagra: 	.word 190, 467, 324, 51, 128, 202      # Drug 1 Prices
    lipitor: 	.word 36, 15, 41, 9, 54, 67            # Drug 2 Prices
    ventolin: 	.word 4043, 343, 1398, 365, 187, 604   # Drug 3 Prices
    lantus: .word 6336, 955, 1395, 705, 982, 1696  # Drug 4 Prices
    prozac: .word 25, 23, 62, 7, 30, 95            # Drug 5 Prices
    xanax: .word 300, 500, 400, 200, 600, 700     # Drug 6 Prices

.text
.globl main

main:
 


    # Step 2: Display the selection prompt
    li $v0, 4                 # Syscall for print string
    la $a0, select_prompt     # Load address of prompt string
    syscall                   # Print prompt

    # Step 3: Read user input (integer)
    li $v0, 5                 # Syscall for read integer
    syscall                   # Read integer input
    move $t0, $v0             # Move input to $t0 (selected_drug)

    # Step 4: Validate input (1-6)
    blt $t0, 1, invalid_input_handler # If input < 1, invalid
    bgt $t0, 6, invalid_input_handler # If input > 6, invalid

    # Step 5: Select the corresponding drug prices array
    beq $t0, 1, viagra
    beq $t0, 2, lipitor
    beq $t0, 3, ventolin
    beq $t0, 4, lantus
    beq $t0, 5, prozac
    beq $t0, 6, xanax

# Subroutines for each drug
viagra_1:

# Step 1: Draw country 1 row: RED  -> 0x00FF0000
    li $a0, 0          # Start column (x-coordinate)
    li $a1, 0          # Row (y-coordinate)
    li $a2, RED        # Color (RED)
    li $a3, 128        # Length of the row
    jal draw_row

    j end_program

lipitor_2:
    la $t1, lipitor     # Load address of drug2_prices into $t1
    jal draw_row        # Call subroutine to draw bar chart
    j end_program

ventolin_3:
    la $t1, ventolin     # Load address of drug3_prices into $t1
    jal draw_row        # Call subroutine to draw bar chart
    j end_program

lantus_4:
    la $t1, lantus     # Load address of drug4_prices into $t1
    jal draw_row        # Call subroutine to draw bar chart
    j end_program

prozac_5:
    la $t1, prozac     # Load address of drug5_prices into $t1
    jal draw_row        # Call subroutine to draw bar chart
    j end_program

xanax_6:
    la $t1, xanax     # Load address of drug6_prices into $t1
    jal draw_row        # Call subroutine to draw bar chart
    j end_program



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
    j main                    # Restart the program

# Subroutine to end the program gracefully
end_program:
    li $v0, 10                # Syscall for exit
    syscall                   # Exit the program