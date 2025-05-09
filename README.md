# Memorable Password Generator

Copyright ©️2025 Paul Suh

This is a simple script to generate random passwords based on open two
word compound nouns, like "writing tablet". This makes them easy to
remember since they represent a single concept, unlike a pair of
unrelated words. The punctuation is chosen from the set of characters
that can be typed on an iPhone using the numeric mode of the standard
keyboard. This makes it easy to type on an iPhone.

## Usage

    ./memorable_password_gen <num passwords (def=10)> <min len (def=15)>

The generated passwords will be of the form:

    [word1][digit][punctuation][word2]

By default the script will generate 10 potential passwords that are
at least 15 characters in length. One example run produces: 

    $ ./memorable_password_gen.sh 
    Artesian8,Borer
    Dirigible7:Balloon
    Subconscious3$Urge
    Biphenyl2'Rearrangement
    Bluecoat1&School
    Telephone9?Cabinet
    Hydraulic8:Tailgate
    Hydrosulphurous3?Acid
    Dipodic3:Rhythm
    Puerperal8(Fever

You can then select one of them that suits you as your new password.

## Underlying Details

The open compound nouns are taken from the file `256772co.mpo`, part
of the [Moby list][link01]. The words in the file were filtered to
remove compound nouns where one of the parts is less than four
characters long, has more than two parts, or is a proper noun. 

The list of actual words is stored in the bottom of the script itself,
which is why the script is so large, almost 38k lines and 609k bytes.
Only the first 146 lines is the script, and about half of that is
either comments or whitespace. 

The script runs entirely locally and does not communicate with any
remote systems. You can be confident that any password you generate
will be completely private. 

## License

Distributed under the terms of the `MIT` license,
`memorable-password-gen` is free and open source software.

[link01]: https://ai1.ai.uga.edu/ftplib/natural-language/moby/moby.tar.Z
