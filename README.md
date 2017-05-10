# User-Centric Implementation of a Parametric Audio Equalizer Using Digital Signal Processing on the Altera DE2-115
Completed by Mark Kubiak and James Ickes at the University of Illinois as the final project of the ECE 385 course for the Spring 2017 semester.  

# Abstract  
This project successfully set out to implement a user-friendly and powerful parametric audio equalizer on the Altera DE2-115 Development Board.  At a high level, the end user is able to arbitrarily define up to eight concurrent digital filters that take input from the Line In 3.5mm jack and modify the sound sent to the Line Out jack.  These audio-focused filters are created by the user, who enters the qualities of a filter as prompted by a VGA display.  The display also relays the types of filters implemented and a logarithmic graph representing the modifications performed by the digital filter array.  The digital signal processing is performed by two arrays of eight digital filters (one per channel) connected in series.  Each filter is implemented as a standard “biquad” IIR filter, which takes 5 arbitrary coefficients to modify the input signal.  Peak EQ, low shelf, high shelf, low pass, and high pass filters were all implemented for this project.  The end result is a powerful parametric audio equalizer that is applicable for room correction, headphone/speaker tuning, digital crossovers, or simply changing the sound signature to match a user’s preferences.  

# Repository Overview  
This repository contains the code and lab report for the final project.  The lab report, in PDF format, can be found in the root of the repository as ["FinalProjectReport.pdf"](FinalProjectReport.pdf).  The provided code is complete; any user with an Altera DE2-115 is free to build and test the project.  The following steps build and run the project on Quartus Web Edition 15.0:  
1. Open the Final_Project.qsf file in Quartus.  
2. In QSYS, open "nios_system.qsys".  Generate the HDL for that file and check to make sure it is imported into the project.  
3. Run a full compilation in Quartus.  This will take awhile.  
4. When the compilation is complete, open the NIOS II SBT for Eclipse.  Import software/usb_kb and software/usb_kb_bsp as "NIOS II SBT Projects" in Eclipse.  
5. Generate the BSP for usb_kb_bsp and run a full Build.  
6. Flash output_files/Final_Project.sof to the DE2-115.  When finished, use Eclipse to run the software portion.  
7. Attach a VGA display, USB keyboard, Audio In (blue 3.5mm jack), and Audio Out (green 3.5mm jack)  

# Copying
All provided code is free to download and run, but copying portions or the entirety of code to use in other projects is forbidden without the permission of both Mark Kubiak and James Ickes.
