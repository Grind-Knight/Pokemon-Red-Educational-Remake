# Pokémon Red Educational Remake

An educational project for new developers, this initiative aims to recreate the original Pokémon Red game using Dream Maker (DM). It's a community-driven project designed to provide hands-on experience and an engaging learning platform for both experienced and novice developers.

## Table of Contents
- [Introduction](#introduction)
- [Getting Started](#getting-started)
- [Features](#features)
- [Coding Style](#coding-style)
- [Contribution](#contribution)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## Introduction

The Pokémon Red Educational Remake project is more than just a clone of the classic game. It's a means to explore the fundamentals of programming, game design, and collaboration using the DM language.

## Getting Started

### Prerequisites

- Dream Maker (latest version)
- Basic knowledge of DM programming

### Installation

1. Clone the repository: `git clone https://github.com/your-organization/Pokemon-Red-Educational-Remake.git`
2. Open the project using Dream Maker.
3. Compile and run the game.

## Features

- Faithful recreation of Pokémon Red
- Structured codebase following DM best practices
- Interactive tutorials and documentation for beginners
- Community support and mentorship

## Coding Style

This project adheres to a specific coding style to maintain consistency. Please refer to the coding convention example provided:
```dm
#define macro_def(x)
#define PROPERTY_DEF

var
  const
    GLOBAL_CONST = 1

var
  global_var

proc
  global_proc(arg_one, arg_two)

custom_type  //Or any datum, which includes ATOM
  var
    our_variable
    _private_variable
    __secret_variable

custom_type
  proc
    OurProc(arg_one, arg_two)
      var/local_var

custom_type
  verb
    Our_Verb(arg_one as type)
```

## Contribution

Contributions are welcome! If you're interested in participating, please:

1. Fork the repository
2. Create a new feature branch
3. Commit your changes
4. Submit a pull request

Be sure to follow the coding style and guidelines.

## License

This project is licensed under the GNU General Public License v3 (GPLv3) - see the [LICENSE.md](LICENSE.md) file for details. By adhering to this license, contributors and users must follow the stipulations for sharing, modifying, and distributing the code, ensuring that the same freedoms are passed on to derivative works.

## Acknowledgments

- Thanks to all the community members and mentors for their support and dedication.
- Special thanks to Nintendo and Game Freak for the original Pokémon Red game.

---

Happy coding and let's catch 'em all together!
