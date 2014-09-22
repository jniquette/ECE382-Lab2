ECE382-Lab2 MSP430 XOR Decrypter
======================================

##Purpose
This project takes a given ciphertext and key along with their corresponding lengths and then XORs the ciphertext and key together to reveal the plain text. 

##Prelab
The prelab lab for this exercise consisted of designing a software flowchart to aid in programming.

###Software Flowchart
![alt text](https://github.com/jniquette/ECE382-Lab2/blob/master/images/software_flowchart.png "Original Software Flowchart")

###Modifications to Original Design
Only one logical modification was made to the original design. In the first flowchart I forgot to increment the key counter after getting the next byte of the key.

The following flowchart shows the modified sequence of events.
![alt text](https://github.com/jniquette/ECE382-Lab2/blob/master/images/software_flowchart2.png "Modified Software Flowchart")

##Code
All code for this project can be found in code/main.asm.

##Debugging
I was lucky to only have had to debug once which led me to my code modification. While debugging the program I noticed that only the first byte was decrypting correctly. This was because I wasn't incrementing the counter for the key length, so the key never reset and the "next value" in the key was just whatever followed the key in ROM.

##Testing Methodology
In order to test functionality I tested the following four three test cases. The only case I did not test was "A Functionality" because I just didn't have the time to make that happen.

##Test Cases

###Basic Test
####Input:	
	Encrypted Message: 0x9EF9
	Key: 0xBEEF
	Expected Result: 0x2016
	Result: 0x2016

###Required Functionality
####Input:	
	Encrypted Message: 0xefc3c2cbdecdd8d9c0cdd8c5c3c2df8d8c8cf5c3d98cc8c9cfded5dcd8c9c88cd8c4c98ce9efe99f949e8cc4c5c8c8c9c28cc1c9dfdfcdcbc98ccdc2c88ccdcfc4c5c9dac9c88cdec9ddd9c5dec9c88ccad9c2cfd8c5c3c2cdc0c5d8d58f
	Key: 0xac

Expected Result: Unknown, assumed to be in the range of printable characters.

Actual Result: 
	Hex: 0x436F6E67726174756C6174696F6E73212020596F752064656372797074656420746865204543453338322068696464656E206D65737361676520616E642061636869657665642072657175697265642066756E6374696F6E616C69747923
	ASCII:	Congratulations!.. You.decrypted.the.ECE382.hidden.message.and.achieved.required.functionality#

Analysis: The code produced a human-readable message, so the program seems to have worked.

###B Functionality
####Input: 
	Encrypted Message: 0xf8b7468cb246dfac42cbba03c7ba5a8cb346c2b857c4ff4adfff129aff41c5ab5082ff03e5ab03c3b14fd5ff40c3b157cdb64ddfff4fc9ab57c9ad5080ff53c9ad4ac3bb5080ff42c2bb03dfaf42cfba508f
	Key: 0xacdf23

Expected Result: Unknown, assumed to be in the range of printable characters.

Actual Result: 
	Hex: 0x546865206D657373616765206B6579206C656E67746820697320313620626974732E20204974206F6E6C7920636F6E7461696E73206C6574746572732C20706572696F64732C20616E642073706163657323
	ASCII:	The.message.key.length.is.16.bits...It.only.contains.letters,.periods,.and.spaces#

Analysis: The code produced a human-readable message, so the program seems to have worked.

###A Functionality
Not tested.

##Observations
Once while testing the B Functionality Test Case the MSP430 outputed a result similar to "............................................contains.letters,.periods,.and.spaces#". I was unable to determine why this happened nor was I able to duplicate the result.


##Documentation Statement
Nothing to report.