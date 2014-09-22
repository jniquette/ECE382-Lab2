ECE382-Lab2 MSP430 XOR Decrypter
======================================

##Purpose


##Prelab

###Software Flowchart
![alt text](https://github.com/jniquette/ECE382-Lab1/blob/master/images/software_flowchart.png "Original Software Flowchart")

###Modifications to Original Design


The following flowchart shows the modified sequence of events.
![alt text](https://github.com/jniquette/ECE382-Lab1/blob/master/images/software_flowchart2.png "Modified Software Flowchart")

##Code
All code for this project can be found in code/main.asm.

##Testing Methodology


##Test Cases
###Required Functionality
####Input:	
	Encrypted Message: 0xefc3c2cbdecdd8d9c0cdd8c5c3c2df8d8c8cf5c3d98cc8c9cfded5dcd8c9c88cd8c4c98ce9efe99f949e8cc4c5c8c8c9c28cc1c9dfdfcdcbc98ccdc2c88ccdcfc4c5c9dac9c88cdec9ddd9c5dec9c88ccad9c2cfd8c5c3c2cdc0c5d8d58f
	Key: 0xac

Expected Result: Unknown, assumed to be in the range of printable characters.

Actual Result: 
	Hex:	0x436F6E67726174756C6174696F6E73212020596F752064656372797074656420746865204543453338322068696464656E206D65737361676520616E642061636869657665642072657175697265642066756E6374696F6E616C69747923
	ASCII:	Congratulations!.. You.decrypted.the.ECE382.hidden.message.and.achieved.required.functionality#

Analysis: The code produced a human-readable message, so the program seems to have worked.

###B Functionality
####Input: 
	Encrypted Message: 0xf8b7468cb246dfac42cbba03c7ba5a8cb346c2b857c4ff4adfff129aff41c5ab5082ff03e5ab03c3b14fd5ff40c3b157cdb64ddfff4fc9ab57c9ad5080ff53c9ad4ac3bb5080ff42c2bb03dfaf42cfba508f
	Key: 0xacdf23

Expected Result: Unknown, assumed to be in the range of printable characters.

Actual Result: 
	Hex:	0x546865206D657373616765206B6579206C656E67746820697320313620626974732E20204974206F6E6C7920636F6E7461696E73206C6574746572732C20706572696F64732C20616E642073706163657323
	ASCII:	The.message.key.length.is.16.bits...It.only.contains.letters,.periods,.and.spaces#

Analysis: The code produced a human-readable message, so the program seems to have worked.

###A Functionality
Input: 

Expected Result: Unknown, assumed to be in the range of printable characters.

Actual Result:

Analysis: 

##Observations


##Documentation Statement
Nothing to report.