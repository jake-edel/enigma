# <p align="center">🕵 💬 🔐 E N I G M A 🤫 📅 🤐</p>
![enigma_illustration_scaled](https://user-images.githubusercontent.com/79817178/149670136-1278284f-66e8-4e68-8608-a25d8f621d2c.jpg)
### <p align="center">**A command line introduction to cryptography**</p>

---

#### Table of Contents
- [Introduction](#introduction)
- [Under The Hood](#underthehood)
- [Calculating Shifts](#shifts)
- [Encoding The String](#encrypt)
- [Decoding The String](#decrypt)
- [Considerations](#considerations)
- [Self Assessment](#assessment)
- [Additional Resources + Context](#context)
- [A Brief Anecdote](#storytime)

<a name="introduction"/>
<b>Introduction</b>
</a></br></br>
The top level of Enigma consists of two files, `encrypt.rb` and `decrypt.rb`. To begin, create a .txt file inside the`msgs/` containing you message to be encrypted.

To encrypt the file, call the command `ruby lib/encrypt.rb <file_name> <output_file>`</br>
- `<file_name>` - name of file containing text to be encoded, must be inside of the `msgs/` directory.
- `<output_file>` - name of file to be created in the `msgs/` directory with the encoded text written to it.

For Example:  `ruby lib/encrypt.rb msg.txt crypto.txt` This will read the text inside file `msgs/msg.txt`, and write the encoded text to `msgs/crypto.txt`

Both encrypt an decrypt will output the key and the date used for encryption. It is important to note the encrypt these keys in order to decrypt the message.

<a name="under the hood"/>
Under the Hood
</a>

The encryption algorigthim is based around three variables.
- An arbitrary length string to be encoded
- A 5 digit "key" string
- A 6 digit "date" string

The string is chosen by the user and must be manually written in to a `.txt` file in the `msgs/ directory`. The 5 digit key is a randomly generated string of digits, outputted to terminal upon sucessful encryption. The 6 digit date is generated from today's date, in the format `<DDMMYY>`, with zero padded values.

The first step is to generate 4 "shift" values. Each value determines how far a character is to be shifted to a different character. The first character is shifted by the first shift value, the second by the next shift value, and so on. Upon completing the fourth shift, the values start over from the first.

The "set" of characters used for shifting are the letters `a`to `z`, plus a single whitespace `' '` character. Characters in the string will be shifted according to this pattern. Any characters are not included in this set are not shifted and preserved in the encoded message.

<a name="shifts"/>
<b>Calculating Shifts</b>
</a></br></br>
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

<a name="encrypt"/>
<b>Encoding The String</b>
</a></br></br>

Using the collection of shift values, each character is encoded with a corresponding shift value. Starting with the first character and the first shift value, the character is shifted through the set of shiftable characters. The character is moved forward through the collection, the length determined by the value. Shifts the extend beyond the length of the collection, the character is wrapped around starting at `a`.

The second character will be shifted by the second shift value, the third by the third value, and so on. Once four characters have been shifted, the shift sequence repeats from the beginning. Any character not shifted will not advance the procession of shifts.
Ex. The string, `aaaaa`, and shift collection `[1, 2, 3, 4]`, will interact as follows.
- 1st Shift: `a` shifted by 1 is `b`
- 2st Shift: `a` shifted by 2 is `c`
- 3st Shift: `a` shifted by 3 is `d`
- 4st Shift: `a` shifted by 4 is `e`
- 5st Shift: `a` shifted by 1 is `b`
- The encoded string will be `bcdeb`

<a name="decrypt"/>
<b>Decoding The String</b>
</a></br></br>
Decoding works on the same priciples and methods as the encoding, with one difference. Rather than advancing forward through the character set, it will reverse the letter shift. Using the encoded string and shifts from above, the string `bcdeb` will be decrypted back to `aaaaa`.
- 1st Shift: `b` reverse shifted by 1 is `a`
- 2st Shift: `c` reverse shifted by 2 is `a`
- 3st Shift: `d` reverse shifted by 3 is `a`
- 4st Shift: `e` reverse shifted by 4 is `a`
- 5st Shift: `b` reverse shifted by 1 is `a`
- The encoded string will be `bcdeb`

<a name="considerations"/>
<b>Considerations</b>
</a></br></br>
The algorithim will not preserve character case, and thus the decrypted message will not reflect the character case of the original message.

Any symbols or characters outside of the given set will not be shifted, and will have their index and value preserved in the encoded message.

Any whitespace in the message will be shifted, and will likely be encoded as a different character. Similarly, any character can be shifted to a whitespace.

The key and date generated to encode the string will only be printed to the terminal once, upon completion of an encryption. In order to decrypt the message, the key and date must be given as an argument to the decrypt command. Loss of the key will render one unable to decrypt using this algorithim. However, the date key is generated from the date of encryption, and can be easily worked out if the encryption date is known.

<a name="assessment"/>
<b>Self Assessment</b>
</a></br></br>
Based off [this rubric](https://backend.turing.edu/module1/projects/enigma/rubric), my assessment of my progress is as follows:

**Functionality**: At this moment, I currently meet, not exceed expectations for the project. The CLI and encrypt/decrypt function work as expected, but I have not yet sucessfully implemented cracking functionality. I hope to submit the project with this fucntionality in place. As an aside, the cracking algorithm is one of the most interesting challenges I've ever attempted to code, and has solving it has become a multi-day obession for me. If you have a solution, or just want to talk through the ins and outs of the problem, please reach out.

**OOP**: If introducing a module qualifies as above expectations, then I believe my project fits that criteria. The functionality for generating keys/ dates is tucked away in a generator class, and is called by multiple other classes in different contexts. Aside from the KeyGen module, all my others classes do their best to adhere to the principle of single responsibility. class Interface deals strictly with the CLI and file I/O, the calculation of shifts is contained entirely within OffsetFinder and the actual shifting of characters is handled by CharacterShifter. These classes call eachother and pass strictly necessary data back and forth, but have very little knowledge of each others functionality.

**Ruby Conventions and Mechanics**: I rely heavily on a linter (Rubocop) to report errors/breaks from convention in my syntax and code structure. Assuming the rules of Rubocop are in line with the cannonical Ruby style guide, I would hope that my code very closely adheres to Ruby convention. I've made every attempt to encapsulate complex or terse logic inside of methods with semantically meaningful names, with the goal of allowing my higher level logic to read like an English sentance. Whenever possible, I tried to use the enumerable which would allow for the cleanest code, and have tried to avoid the overuse of accumulators and local variables, in favor of efficient enumerators and descriptive methods. While I have very little experience reading professional Ruby code, I believe that adherence to these guidelines places the project above expectations.

**TDD**: Throughout the project, I have followed the following pattern for development as closely as possible: Outline basic class / test structure, identify the functionality that I require, writing tests to expect this functionality, writing empty methods to avoid a no method error, identifying the arguments reqired by the method, and then opening the method in Pry to begin manipulating the variable in scope. Once I found a working solution, I would paste the code into the method and ensure that the method meets expectation, and that the test fails when the expectation/method is incorrect. Currently sitting at 98% coverage due to continued development on the cracking feature, I plan to hit 100% before submission. Assuming that mocks + stubs are no longer part of the criteria, I would hope that this qualifies my project as above expectations.

<a name="context"/>
<b>Additional Resources + Context</b>
</a></br></br>
While not relavant to this algorithim specifically, here are some interesting facts, content, and resources relating to the cracking of Enigma.

![enigma](https://user-images.githubusercontent.com/79817178/149668328-a58a9b0c-8307-47ec-88f3-74e1cd4d4847.jpg)</br>
Enigma Machine [(Source)](https://www.timesofisrael.com/enigma-code-machine-reveals-hebrew-secret/)

[Enigma @ Wikipedia](https://en.wikipedia.org/wiki/Enigma_machine)

[Ultra](https://en.wikipedia.org/wiki/Ultra): Codename for WWII British cryptography division located at Bletchley Park

[Alan Turing and Enigma](https://www.youtube.com/watch?v=d2NWPG2gB_A) from Computerphile on YouTube, part of a [longer series on the work of Turing](https://www.youtube.com/playlist?list=PLzH6n4zXuckodsatCTEuxaygCHizMS0_I)</br>

**CAPTCHA** stands for “**C**ompletely **A**utomated **P**ublic **T**uring test to tell **C**omputers and **H**umans **A**part,”

Cryptography comes from the ancient Greek words **kryptós**, meaning “hidden,” and **graphein**, meaning “to study.”


---
[jake_edel](https://github.com/jake-edel) on GitHub</br>
<a href = "mailto: jakobedelstein@gmail.com">jakobedelstein@gmail.com</a>
