
# <p align="center">🕵 💬 🔐 E N I G M A 🤫 📅 🤐</p></br>

<p align="center">
![enigma_illustration](https://user-images.githubusercontent.com/79817178/149669497-c1f34cce-2a41-42f7-9a6f-29178ec51ee4.jpg)</br>
  ### **A command line introduction to cryptography**
</p>


## <p style="text-align: center;"></p>
### <p style="text-align: center;">**A command line introduction to cryptography**</p>
---


The top level of Enigma consists of two files, `encrypt.rb` and `decrypt.rb`. To begin, create a .txt file inside the`msgs/` containing you message to be encrypted.

To encrypt the file, call the command `ruby lib/encrypt.rb <file_name> <output_file>`</br>
- `<file_name>` - name of file containing text to be encoded, must be inside of the `msgs/` directory.
- `<output_file>` - name of file to be created in the `msgs/` directory with the encoded text written to it.

For Example:  `ruby lib/encrypt.rb msg.txt crypto.txt` This will read the text inside file `msgs/msg.txt`, and write the encoded text to `msgs/crypto.txt`

Both encrypt an decrypt will output the key and the date used for encryption. It is important to note the encrypt these keys in order to decrypt the message.

#### Under the Hood

The encryption algorigthim is based around three variables.
- An arbitrary length string to be encoded
- A 5 digit "key" string
- A 6 digit "date" string

The string is chosen by the user and must be manually written in to a `.txt` file in the `msgs/ directory`. The 5 digit key is a randomly generated string of digits, outputted to terminal upon sucessful encryption. The 6 digit date is generated from today's date, in the format `<DDMMYY>`, with zero padded values.

The first step is to generate 4 "shift" values. Each value determines how far a character is to be shifted to a different character. The first character is shifted by the first shift value, the second by the next shift value, and so on. Upon completing the fourth shift, the values start over from the first.

The "set" of characters used for shifting are the letters `a`to `z`, plus a single whitespace `' '` character. Characters in the string will be shifted according to this pattern. Any characters are not included in this set are not shifted and preserved in the encoded message.

#### Calculating Shifts

The four shift values are calculated based on the `key` and `date` variables. Each variable is used to generate a collection of four integers. The two collections' respective indecies are summed, resulting in four integers which become our "shifts"

The 5 digit key is split into four collections of two digit consecutive values. These digits are joined together into an integer to give us our first half of the shift calculation.
- Ex. The Key `12345` would split into the consecutive values `(1, 2), (2, 3), (3, 4), (4, 5)`, and then each pair joined to become the collection `[12, 23, 34, 45]`

The 6 digit date is squared, and the last four digits of the squared value form a collection to be summed with the four keys.
- Ex. The date string `'160122'` is squared, resulting in `25,639,054,884`. The last four digits stripped out return the collection [4, 8, 8, 4]

Once both collections have been calculated, they are summed together, while preserving the index location and collection length. Given two collections `[12, 23, 34, 45]` and `[4, 8, 8, 4]`, the calculation is as follows
- 12 + 4 = 16
- 23 + 8 = 31
- 34 + 8 = 42
- 45 + 4 = 49

And the resulting shifts collection is `[16, 31, 42, 49]`

#### **Encoding the String**
Using the collection of shift values, each character is encoded with a corresponding shift value. Starting with the first character and the first shift value, the character is shifted through the set of shiftable characters. The character is moved forward through the collection, the length determined by the value. Shifts the extend beyond the length of the collection, the character is wrapped around starting at `a`.

The second character will be shifted by the second shift value, the third by the third value, and so on. Once four characters have been shifted, the shift sequence repeats from the beginning. Any character not shifted will not advance the procession of shifts.
Ex. The string, `aaaaa`, and shift collection `[1, 2, 3, 4]`, will interact as follows.
- 1st Shift: `a` shifted by 1 is `b`
- 2st Shift: `a` shifted by 2 is `c`
- 3st Shift: `a` shifted by 3 is `d`
- 4st Shift: `a` shifted by 4 is `e`
- 5st Shift: `a` shifted by 1 is `b`
- The encoded string will be `bcdeb`

#### **Decoding the String**
Decoding works on the same priciples and methods as the encoding, with one difference. Rather than advancing forward through the character set, it will reverse the letter shift. Using the encoded string and shifts from above, the string `bcdeb` will be decrypted back to `aaaaa`.
- 1st Shift: `b` reverse shifted by 1 is `a`
- 2st Shift: `c` reverse shifted by 2 is `a`
- 3st Shift: `d` reverse shifted by 3 is `a`
- 4st Shift: `e` reverse shifted by 4 is `a`
- 5st Shift: `b` reverse shifted by 1 is `a`
- The encoded string will be `bcdeb`

#### **Considerations**
The algorithim will not preserve character case, and thus the decrypted message will not reflect the character case of the original message.

Any symbols or characters outside of the given set will not be shifted, and will have their index and value preserved in the encoded message.

Any whitespace in the message will be shifted, and will likely be encoded as a different character. Similarly, any character can be shifted to a whitespace.

The key and date generated to encode the string will only be printed to the terminal once, upon completion of an encryption. In order to decrypt the message, the key and date must be given as an argument to the decrypt command. Loss of the key will render one unable to decrypt using this algorithim. However, the date key is generated from the date of encryption, and can be easily worked out if the encryption date is known.

#### **Additional Resources + Context**
While not relavant to this algorithim specifically, here are some interesting facts, content, and resources relating to the cracking of Enigma.

![enigma](https://user-images.githubusercontent.com/79817178/149668328-a58a9b0c-8307-47ec-88f3-74e1cd4d4847.jpg)</br>
Enigma Machine [(Source)](https://www.timesofisrael.com/enigma-code-machine-reveals-hebrew-secret/)

![Enigma_wiring](https://user-images.githubusercontent.com/79817178/149668364-80fc786a-7009-4dc3-b171-08fb32b11c52.png)</br>
Enigma Machine Wiring + Article from [Wikipedia](https://en.wikipedia.org/wiki/Enigma_machine)

[Ultra](https://en.wikipedia.org/wiki/Ultra): Codename for WWII British cryptography division located at Bletchley Park

[Alan Turing and Enigma](https://www.youtube.com/watch?v=d2NWPG2gB_A) from Computerphile on YouTube, part of a [longer series on the work of Turing](https://www.youtube.com/playlist?list=PLzH6n4zXuckodsatCTEuxaygCHizMS0_I)</br>

**CAPTCHA** stands for “**C**ompletely **A**utomated **P**ublic **T**uring test to tell **C**omputers and **H**umans **A**part,”

Cryptography comes from the ancient Greek words **kryptós**, meaning “hidden,” and **graphein**, meaning “to study.”

#### **A Brief Anecdote**

The ideas underpinning enigma machine were originally patented in Germany in 1918, and the finished product was released to market in 1923, under the brand name Enigma. Initally developed for commercial purposes, and was later adopted by the German military prior to WWII.

A UK based team of mathmaticians and cryptographers, including Alan Turing, have been widely credited with cracking the Enigma encryption, as dramatized in the 2014 film, *'The Imitation Game'*. However, the foundation of their work was based on the earlier work of a team of  Polish mathmetician-cryptologists, who had broken more primative German ciphers as early as 1933.

Aside from his work at Bletchley Park, which is recognized as having given the Allies a critical strategic advantage during WWII, Alan Turing's work has formed part of the foundation upon which all of Computer Science is built upon. However, cracking of Enigma was classified until 1974, and he was never able to recieve credit for his contribtion to the Allies eventual victory.

Alan Turing died a tragic and premature death in 1954, at the age of 41. He was prosecuted for his sexuality, and recieved punishment so cruel, inhumane and barbaric, that it defies comprehension by modern standards. A public apology was issued in 2009, and a posthumous pardon was granted by Queen Elizabeth II in 2013, nearly 60 years after his death.

Had it not been for his contributions to military and industry, Alan Turing would likely have remained unknown and anonymous. The legacy of his work helped form the foundation of computing and the modern world, but his story serves as a stark reminder of a disturbing history of human rights that must be acknowledged and reckoned with.

He is a very visible example of the countless individuals who, to this day, are persecuted based on their identity, regardless of the content of their character, or their contributions to the lives of others, and humanity at large.

---
[jake_edel](https://github.com/jake-edel) on GitHub</br>
<a href = "mailto: jakobedelstein@gmail.com">jakobedelstein@gmail.com</a>
