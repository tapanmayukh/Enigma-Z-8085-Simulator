# ENIGMA-Z 8085 Simulator
This simulator was part of a mini-project for Electronics-II Laboratory. The project was to build a working model based on digital electronics or 8085 Microprocessors.

While most people were busy making counters and fibonacci series generators, I wished to build something different. The idea came about from a Numberphile video based on [ENIGMA Machines](https://youtu.be/G2_Q9FoD-oQ, "Enigma Machine - Numberphile"). I searched around for a numbers-only version of the machine and found [this article on ENIGMA-Z](https://www.cryptomuseum.com/crypto/enigma/z/index.htm, "Numbers-only ENIGMA Z30").

## ENIGMA-Z

The simulator implements the 3-rotor (**German:** Walzen) and 1-reflector (**German:** Umkehrwalze or UKW) mechanism with the following scramble:

|  Rotor    |    Scramble    |
|:---------:|---------------:|
|   I       |    7036418259  |
|   II      |    1367052489  |
|   III     |    7120538649  |
|   UKW     |    7594318062  |

The file `enigma.asm` can be used directly to simulate the Enigma-Z on the using [GNU8085Sim](https://gnusim8085.github.io/).
* The rotor order is fixed as I, II and III.
* The starting ring settings (**German:** Ringstellung) need to inserted in ports `10h, 11h and 12h`.
* The number to be encoded is put in the port `13h`.
* The program outputs the encoded number at the port `14h`.

But, the code in `Enigma_Dyna85.pdf` has modifications with specific built-in sub-routines from [Dyna-85 Kit](https://www.dynalogindia.com/shop/dyna-85/) and can be assmbled using that and uses an ENIGMA Machine like approach with almost 0.5 seconds (due to 3 MHz clock speed of Dyna85) popping up of the encoded message and then moving on for next input. The same settings can be used to decode the message again.

**NOTE:** The program is not optimised to discard `0Ah` to `0Fh` input and thus should be carefully used.
