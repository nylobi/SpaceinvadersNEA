defineRegisters:
	mov r6,#55
	mov r7,#144
	mov r0,#0
	mov r1,#0
	mov r2,#0

main:
	mov r0,#5
	mov r1,#7
	bl drawGridOfInvaders
	mov r0,#144
	bl PaintScreen
	halt

drawRowOfInvaders:		//given number of columns in r0,row vertical position in r1, draws a row of invaders with a space of one
	push {lr,r0-r3}
	mov r3,r0		//r3 is now the counter
	mov r0,#0
	
loopRow:
	bl drawSingleSpaceInvader
	add r0,r0,#2		//2 is the horisontal spacing
	sub r3,r3,#1
	cmp r3,#0
	bgt loopRow
	pop {lr,r0-r3}
	mov pc, lr

drawGridOfInvaders:		//given number of columns in r0, number of rows in r1, draws a grid of invaders with a horizontal space of one and a vertical space of one.
				
	push {lr,r0-r2}
	lsl r1,r1,#1		//logically shift left by one place (*2)
	
loopGrid:
	//set number of columns and vertical position	
	bl drawRowOfInvaders
	//count and loop the drawRow
	sub r1,r1,#2
	cmp r1,#0
	bgt loopGrid
	pop {lr,r0-r2}
	mov pc, lr
	

drawSingleSpaceInvader:		//given a value for x in r0,y in r1, draws a spaceinvader at that location
	push {lr}
	bl calculateXYLocation	//gets the screen pos in r2
	strb r6,[r2+3328]
	pop {lr}
	mov pc, lr		//Return from a subroutine

calculateXYLocation:		//given a value for x in r0, y in r1, returns screen position in r2
	push {lr,r0-r1}		//restore all value EXCEPT THE RETURN VALUE
	mov r2,#0
loopY:				//calculating y
	add r2,r2,#32
	sub r1,r1,#1
	cmp r1,#0
	bgt loopY
	add r2,r2,r0		//calculating left
	pop {lr,r0-r1}
	mov pc, lr		//return from a subroutine

PaintScreen:			//changes all squares to the colour defined in r0
	push {lr,r1}
	//colour in all the squares white by starting at square 0, and increasing the counter by one each time the loop finishes.
	mov r1,#767
loopPaint:
	strb r0,[r1+3328]
	sub r1,r1,#1
	cmp r1,#0
	bgt loopPaint	
	pop {lr,r1}
	mov pc, lr
	
	
	
