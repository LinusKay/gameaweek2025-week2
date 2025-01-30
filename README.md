# Game-A-Week: Week Two

> Game-a-Week is an intensive program in which participants will create 6 prototype games  — one game each week. The aim of this program is to get comfortable with the practice of rapid prototyping: working quickly to create a small playable game that effectively proves or disproves a design concept. Additionally, by working on small projects with low stakes, we can open ourselves up more readily to feedback. Drawing influence from game jams, the program will prompt you with weekly thematic, aesthetic, or mechanical constraints (e.g. “time” or “black-and-white” or “one-button input”).

## Game: Memory Vendor

!["Showcase image"](/showcase/memoryvendor.png)

> ...

### Controls

|Keys|Control|
|-------|----|
|w a s d|move
|shift|run
|m|view memories
|arrows|select vending item
|e f enter| interact
|click|drink


## Discussion

Theme #2 for 2025 Game-A-Week was "memory". 


### Concept

Week 2 was another that I already had a concept brewing in the back of my head for. I liked the idea of a skill-memory system, where in order to learn a new skill, you have to let go of one of the character's memories. This loss of memory would be somewhat of an eerie, emotional driver for the character, but also impact the world around them, with objects and inventory items losing their names or descriptions, reaching so far as to delete UI elements.

In order to keep scope small, I avoided actually creating any "skill" gameplay, and focused on a proof-of-concept of memory trading. I had a vending machine model laying around so it came together quickly enough.

The 3d memory inventory system, AKA the "memory ring" was inspired by some 90s/2000s games which really played with presenting items in an abstract physical way. Also largely inspired by the inventory in the game [Tower of Tears](https://store.steampowered.com/app/2559740/The_Tower_Of_Tears/) by [xena-spectrale](https://linktr.ee/xena_spectrale), which I love seeing in-dev videos from. 

!["Tower of Tears"](/showcase/Screenshot_2025-01-30_183909.png)

I think its such a fun way, tactile(?) to display what items you have on hand. Much more delicious than a list of text, which was the initial working solution. 

!["Showcase image"](/showcase/Screenshot_2025-01-27_232610.png)


### Development

Soft-promise that next week I probably maybe won't use the dither filter again. Ok, moving on.

Enjoyed playing with lighting this week. What is this void you're in? I have no idea. Or I won't tell. I was originally wanting to create a "fog of war" effect around the player, but found the fog to be a little unwieldy. Lights were much easier to work with, and created a better looking effect. Where is this light coming from? Why isn't there more?

The most painful part was creating the mamory ring. Again, first time working with some 3d concepts so I was bashing my head against tram windows trying to make the darn thing rotate how it rotated in my head. I do not understand 3d mathematics. I am not meant to know what a radian is. I was built to bang rocks together. It would rotate too much, too little, not at all, all at once. Seeing it come together in my kitchen as my housemate prepped dinner was almost as good as the green curry that came after. 

It was also such a joy when I thought it might be tricky to get 3d text working, mostly based off a comment i saw on a godot threat saying they with Label3D was included in base, and then realising Label3D *is* included in base now. Love seeing the vending items show above its head.

Writing the memories was the last part I finished up. I struggled to convey the right "feeling" or "mood" with them, and wasn't sure whether I wanted to just display a vague name, or a longer description. In the end I opted for both, but keeping the names vague. My UI skills still aren't amazing so it was a bit to fit on screen.

This project is still a bit of a mess, and I'm sure I could be using scenes better, but I'm decently happy with how this came together. 

## Resources
* [Godot Dither Shader by Sam Bigos](https://github.com/samuelbigos/godot_dither_shader/)
* [arq4 palette by ENDESGA](https://lospec.com/palette-list/arq4)
* [Fridge Loop 1 | OpenGameArt.org](https://opengameart.org/content/fridge-loop-1) 
* [Vending Machine Sound Effects #SOUNDFX by AFRO NINJA](https://www.youtube.com/watch?v=7FEGMpMF5iU)
* [Gastar Graffiti by Fitrah Type](https://www.dafont.com/gastar-graffiti.font)
* that honk sound from pizza tower