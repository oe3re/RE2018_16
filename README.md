# RE2018_16
Network protocol


Purpose of this project is simulation of the flow of the messages through the network and the response of the devices (00-11) to the messages. Via message you can control one device or all of them. For making this happen, each device has its own address (00,01,10,11). 
Every device on the network receives special instructions that it needs to carry out. Instructions are following: 1.) Turn the diode on 2.) Turn the diode off 3.) IDLE.
Turn on the diode function turns the diode of the selected color on, whereas turn the diode off turns the selected ones off. Which diodes to aim is also sent over the network. Instruction IDLE doesn’t take any action, only the addressed device recognize that it is being addressed. Messages are being sent with a configurable frequency and a period T.
Messages that are being sent are read from the file “protocol.txt” which in one line contains an 8-bit long message. Messages are being read with a period of T and are being sent to all devices. 
Detailed form and description of the message is given. Rectangles of blue color are always activated each time certain device is addressed. Colors change every period T.
