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
    drug1_prices: .word 190, 467, 324, 51, 128, 202      # Drug 1 Prices
    drug2_prices: .word 36, 15, 41, 9, 54, 67            # Drug 2 Prices
    drug3_prices: .word 4043, 343, 1398, 365, 187, 604   # Drug 3 Prices
    drug4_prices: .word 6336, 955, 1395, 705, 982, 1696  # Drug 4 Prices
    drug5_prices: .word 25, 23, 62, 7, 30, 95            # Drug 5 Prices
    drug6_prices: .word 300, 500, 400, 200, 600, 700     # Drug 6 Prices

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
    beq $t0, 1, draw_drug1
    beq $t0, 2, draw_drug2
    beq $t0, 3, draw_drug3
    beq $t0, 4, draw_drug4
    beq $t0, 5, draw_drug5
    beq $t0, 6, draw_drug6

# Subroutines for each drug
draw_drug1:
    la $t1, drug1_prices     # Load address of drug1_prices into $t1
    jal draw_bar_chart        # Call subroutine to draw bar chart
    j end_program

draw_drug2:
    la $t1, drug2_prices     # Load address of drug2_prices into $t1
    jal draw_bar_chart        # Call subroutine to draw bar chart
    j end_program

draw_drug3:
    la $t1, drug3_prices     # Load address of drug3_prices into $t1
    jal draw_bar_chart        # Call subroutine to draw bar chart
    j end_program

draw_drug4:
    la $t1, drug4_prices     # Load address of drug4_prices into $t1
    jal draw_bar_chart        # Call subroutine to draw bar chart
    j end_program

draw_drug5:
    la $t1, drug5_prices     # Load address of drug5_prices into $t1
    jal draw_bar_chart        # Call subroutine to draw bar chart
    j end_program

draw_drug6:
    la $t1, drug6_prices     # Load address of drug6_prices into $t1
    jal draw_bar_chart        # Call subroutine to draw bar chart
    j end_program

# Subroutine to fill the entire screen with a background color
# Pre-condition: $a0 = background color
backgroundColor:
    li $s1, DISPLAY            # Load base address into $s1
    li $s2, WIDTH
    mul $s2, $s2, HEIGHT       # Total pixels = WIDTH * HEIGHT
    mul $s2, $s2, PIXEL_SIZE   # Total bytes = WIDTH * HEIGHT * PIXEL_SIZE
    add $s2, $s1, $s2          # End address = DISPLAY + total bytes

backgroundLoop:
    sw $a0, 0($s1)             # Store color at current address
    addiu $s1, $s1, 4          # Move to next pixel (4 bytes per pixel)
    blt $s1, $s2, backgroundLoop # Repeat until all pixels are colored
    jr $ra                     # Return to caller

# Subroutine to draw a single pixel
# Pre-conditions:
#   $a0 = x-coordinate (0 to WIDTH-1)
#   $a1 = y-coordinate (0 to HEIGHT-1)
#   $a2 = color
draw_pixel:
    mul $t3, $a1, WIDTH        # t3 = y * WIDTH
    add $t3, $t3, $a0          # t3 = y * WIDTH + x
    mul $t3, $t3, PIXEL_SIZE   # Convert to byte offset
    add $t3, DISPLAY, $t3       # Calculate full address: DISPLAY + offset
    sw $a2, 0($t3)              # Store color at calculated address
    jr $ra                      # Return to caller

# Subroutine to draw a bar chart for a specific drug
# Pre-condition:
#   $t1 = address of the drug's prices array
draw_bar_chart:
    li $t8, 0                   # Country index (0-5)
    li $t9, 2                   # Initial X position (pixels)
    li $s0, 30                  # Max bar height (pixels)

draw_bars_loop:
    beq $t8, 6, end_draw_bars  # If all countries processed, exit loop

    # Load the current country's price
    sll $t2, $t8, 2             # Offset = index * 4
    add $t2, $t1, $t2           # Address of current price
    lw $t3, 0($t2)              # Load price into $t3

    # Calculate bar height
    move $a0, $t3               # Set price as argument
    move $a1, $s1               # Set max_price as argument
    move $a2, $s0               # Set max_bar_height as argument
    jal calculate_bar_height    # Call subro
