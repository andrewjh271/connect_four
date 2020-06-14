# Connect Four

Created as part of The Odin Project Curriculum. View on [Github](https://github.com/andrewjh271/connect_four).

### Functionality

Implementation of the game [Connect Four](https://en.wikipedia.org/wiki/Connect_Four). Game ends when a player gets four in a row, or when all spaces are filled.

### Thoughts

The focus of this project was to write it using Test Driven Development. I found starting with tests somewhat useful for my `Board` class, which is the only class to contain methods with much logic. In starting with tests, I was more inclined to try to make my methods limited in their scope, which I found beneficial. It is also nice being able to refactor and quickly confirm that the class still functions correctly.

There wasn't much to test for with the `Player` and `Game` classes — mostly terminal output and user input. These were both difficult and not particularly useful to test.

In my `game_spec.rb` file I originally set the `subject` to an instance of `Game`, and mocked it to receive `gets`, but this created problems when I tried to run all rspec files as a group, rather than just the one file. I know the issue relates to Kernel reading files from command line arguments, but I don't quite understand why Kernel was reached in the first place, since I was trying to mock the method. I eventually settled on using `allow_any_instance_of(Kernel).to receive(:gets)`, but this created new problems with the output. This was related to when `subject` was instantiated, but even knowing that I couldn't get it to behave correctly. I left a number of commented notes in this spec file, because I want to remember some of my troubleshooting process.



