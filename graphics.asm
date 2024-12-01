# MIPS Program: Drug Price Bar Chart
# Description: Displays a bar chart for selected drug prices across six countries using the MARS Bitmap Display.


.data
    # Define Screen Information using .eqv
    .eqv PIXEL_SIZE 4          # Each pixel is 4 bytes (ARGB format)
    .eqv WIDTH 32               # Display width in pixels
    .eqv HEIGHT 32              # Display height in pixels
    .eqv DISPLAY 0x10010000     # Base address for Bitmap Display

    # Define Colors using .eqv (ARGB format)
    .eqv RED     0x00FF0000     # Country 1
    .eqv GREEN   0x0034B818     # Country 2
    .eqv ORANGE  0x00E58E13     # Country 3
    .eqv BLUE    0x002085D0     # Country 4
    .eqv WHITE   0x00FFFFFF     # Country 5
    .eqv YELLOW  0x00FFFF00     # Country 6
    .eqv BLACK 	 0x00000000
    # Prompts and Messages
    select_prompt:   .asciiz "\nEnter the drug number to visualize (1-5): "
    invalid_input:   .asciiz "Invalid input. Please enter a number between 1 and 5.\n"
    header:          .asciiz "\nPrescription Cost Comparison:\n"

    # Drug Prices (Scaled by 100 to handle decimal values)
    # Each drug has six prices corresponding to six countries
    # Format: Drug1: Country1, Country2, ..., Country6
    drug1_prices: .word 190, 467, 324, 51, 128, 202      	# Drug 1 Prices
    drug2_prices: .word 36, 15, 41, 9, 54, 67           	# Drug 2 Prices
    drug3_prices: .word 4043, 343, 1398, 365, 187, 604 		# Drug 3 Prices
    drug4_prices: .word 6336, 955, 1395, 705, 982, 1696 	# Drug 4 Prices
    drug5_prices: .word 25, 23, 62, 7, 30, 95           	# Drug 5 Prices

.text
.globl main

main:
    # Step 1: Fill the background with BLACK
    li $a0, BLACK
    jal backgroundColor

    # Step 2: Display the selection prompt
    li $v0, 4
    la $a0, select_prompt
    syscall

    # Step 3: Read user input (integer)
    li $v0, 5
    syscall
    move $t0, $v0        # $t0 = selected_drug (1-5)

    # Step 4: Validate input (1-5)
    blt $t0, 1, invalid_input
    bgt $t0, 5, invalid_input

    # Step 5: Select the corresponding drug prices array
    li $t1, 0            # Initialize offset
    li $t2, 0            # Initialize pointer to price array

    # Calculate address of selected drug's prices
    beq $t0, 1, select_drug1
    beq $t0, 2, select_drug2
    beq $t0, 3, select_drug3
    beq $t0, 4, select_drug4
    beq $t0, 5, select_drug5

select_drug1:
    la $t2, drug1_prices
    j proceed

select_drug2:
    la $t2, drug2_prices
    j proceed

select_drug3:
    la $t2, drug3_prices
    j proceed

select_drug4:
    la $t2, drug4_prices
    j proceed

select_drug5:
    la $t2, drug5_prices

proceed:
    # Step 6: Find the maximum price to scale the bars
    jal find_max_price

    # Step 7: Draw the header
    li $v0, 4
    la $a0, header
    syscall

    # Step 8: Draw the bar chart
    jal draw_bar_chart

    # Step 9: Exit Program
    li $v0, 10
    syscall

# Subroutine to fill the entire screen with a background color
# Pre-condition: $a0 = background color
backgroundColor:
    li $s1, DISPLAY              # Start address
    li $s2, WIDTH
    mul $s2, $s2, HEIGHT         # Total pixels
    mul $s2, $s2, PIXEL_SIZE     # Total bytes (32x32x4)
    add $s2, $s1, $s2            # End address

backgroundLoop:
    sw $a0, 0($s1)               # Set the color at the current address
    addiu $s1, $s1, 4            # Move to the next pixel
    blt $s1, $s2, backgroundLoop # Repeat until all pixels are colored
    jr $ra

# Subroutine to draw a single pixel
# Pre-conditions:
#   $a0 = x-coordinate
#   $a1 = y-coordinate
#   $a2 = color
draw_pixel:
    mul $t3, $a1, WIDTH          # t3 = y * WIDTH
    add $t3, $t3, $a0            # t3 = y * WIDTH + x
    mul $t3, $t3, PIXEL_SIZE     # Convert to byte offset
    add $t3, $t3, DISPLAY         # Add base address
    sw $a2, 0($t3)                # Store the color at the calculated address
    jr $ra

# Subroutine to find the maximum price in the selected drug's prices array
# Returns:
#   $s1 = maximum price
find_max_price:
    li $t4, 0                     # Index (0-5)
    lw $s1, 0($t2)                # Initialize max with first price

find_max_loop:
    addi $t4, $t4, 1              # Increment index
    beq $t4, 6, end_find_max      # If all prices checked, exit loop
    sll $t5, $t4, 2               # Calculate word offset (index * 4)
    add $t6, $t2, $t5             # Address of current price
    lw $t7, 0($t6)                # Load current price
    ble $s1, $t7, update_max      # If current price > max, update max
    j find_max_continue

update_max:
    move $s1, $t7                 # Update max price

find_max_continue:
    j find_max_loop

end_find_max:
    jr $ra

# Subroutine to calculate bar height based on price and maximum price
# Arguments:
#   $a0 = price
#   $a1 = max_price
#   $a2 = max_bar_height (fixed at 30 pixels)
# Returns:
#   $v0 = bar_height
calculate_bar_height:
    mul $t0, $a0, $a2             # price * max_bar_height
    div $t0, $a1                  # (price * max_bar_height) / max_price
    mflo $v0                      # Retrieve quotient as bar_height
    jr $ra

# Subroutine to draw the bar chart
draw_bar_chart:
    li $t8, 0                      # Country index (0-5)
    li $t9, 2                      # Initial X position (pixels)
    li $s0, 30                     # Max bar height (pixels)

draw_bars_loop:
    beq $t8, 6, end_draw_bars     # If all countries processed, exit loop

    # Load the current country's price
    sll $t1, $t8, 2                # Offset = index * 4
    add $t1, $t2, $t1              # Address of current price
    lw $t2, 0($t1)                  # Load price
    move $a0, $t2                   # Set price as argument
    move $a1, $s1                   # Set max_price as argument
    move $a2, $s0                   # Set max_bar_height as argument
    jal calculate_bar_height        # Calculate bar height
    move $t3, $v0                   # Store bar height

    # Assign color based on country index
    beq $t8, 0, set_color1
    beq $t8, 1, set_color2
    beq $t8, 2, set_color3
    beq $t8, 3, set_color4
    beq $t8, 4, set_color5
    beq $t8, 5, set_color6

set_color1:
    li $a2, RED
    j draw_current_bar

set_color2:
    li $a2, GREEN
    j draw_current_bar

set_color3:
    li $a2, ORANGE
    j draw_current_bar

set_color4:
    li $a2, BLUE
    j draw_current_bar

set_color5:
    li $a2, WHITE
    j draw_current_bar

set_color6:
    li $a2, YELLOW
    j draw_current_bar

draw_current_bar:
    # Calculate the Y position (top of the bar)
    li  $t6, HEIGHT
    subi $a1, $t6, 2            # Bottom of the screen
    sub $a1, $a1, $t3             # Top of the bar

    # Draw the bar as a vertical line
    move $a0, $t9                  # X position
    move $a1, $a1                  # Y position
    move $a3, $t3                  # Bar height
    jal draw_bar

    # Move to the next bar position
    addi $t9, $t9, 3                # bar_width + space (2 + 1)

    # Increment country index
    addi $t8, $t8, 1
    j draw_bars_loop

end_draw_bars:
    jr $ra

# Subroutine to draw a vertical bar
# Pre-conditions:
#   $a0 = x_position
#   $a1 = y_position (top of the bar)
#   $a2 = color
#   $a3 = bar_height
draw_bar:
    li $t4, 0                      # y_offset

draw_bar_loop:
    beq $t4, $a3, end_draw_bar    # If y_offset == bar_height, exit loop

    # Calculate current Y position
    sub $t5, $a1, $t4              # Current y position

    # Draw the pixel
    move $a1, $t5                   # Update y-coordinate
    jal draw_pixel                  # Draw the pixel

    # Increment y_offset
    addi $t4, $t4, 1
    j draw_bar_loop

end_draw_bar:
    jr $ra

# Subroutine to draw a horizontal row of pixels (Not used in this example)
# Included for completeness based on your example
# Pre-conditions:
#   $a0 = start x-coordinate
#   $a1 = y-coordinate (row)
#   $a2 = color
#   $a3 = length of the row
draw_row:
    move $t0, $a0              # Current x-coordinate (start of the row)
    move $t1, $a3              # Length of the row

    # Save $ra (return address) before entering the loop
    addiu $sp, $sp, -4         # Make space on the stack
    sw $ra, 0($sp)             # Save $ra to the stack

draw_row_loop:
    beqz $t1, draw_row_end     # If length is zero, end the loop

    # Draw the current pixel
    move $a0, $t0              # x-coordinate
    move $a1, $a1              # y-coordinate
    move $a2, $a2              # color
    jal draw_pixel             # Call draw_pixel

    # Increment x-coordinate and decrement length
    addi $t0, $t0, 1           # x += 1
    addi $t1, $t1, -1          # length -= 1
    j draw_row_loop

draw_row_end:
    # Restore $ra (return address) after the loop
    lw $ra, 0($sp)             # Load $ra back from the stack
    addiu $sp, $sp, 4          #

