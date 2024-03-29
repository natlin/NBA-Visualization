NBA Basketball Visualization
============================

Team Members
------------
Nathan Lin - 100% of work

Resources
---------
This project used these particuar resources:
* http://savvastjortjoglou.com/nba-play-by-play-movements.html
* https://processing.org/examples/scrollbar.html
* http://teamcolors.arc90.com
* http://i.cdn.turner.com/nba/nba/.element/img/2.0/sect/statscube/players/large/
* LCD5x8H font

Referenced Libraries
--------------------
ControlP5
* ControlP5 was used as a base in order to display much of the user input features, mainly the MenuList of teams and the dropdown list
* The actions that occur after user input are all coded by me.

Please note: If processing says "No library found for ControlP5" please go to the code folder and drag the .jar into the processing application to add it to the sketch, or if loading the visualization via eclipse, add the .jar into the class path.

Explanation
===========
Note: This runs perfectly fine on Windows 64 bit machines. This mayor may not run on Mac computers because of the loadOneGame and loadOneEvent functions which use windows style directory paths.

Note: The shotclock and the gameclock display rounded up values

Note: Everything in the zip file should be at the same level. There is an attached picture, directory.png which shows how the files should be arranged (there all of the files go inside of a folder called main)

Main
----
There is only a single view. The user, when first loading the visualization, will see a few things:
* A basketball court on the right
* A MenuList in the upper left displaying the teams (Abbreviation, Team Name, Team ID, and logo)
* A Dropdown List on the left underneath the MenuList
* A Pause Button and a Next Event Button
* A Slider at the bottom of the screen

In this initially loaded visualization, the dropdown list and the Pause/NextEvent buttons do not do anything. because there is no data associated with those particular input methods yet.

First, the user will select a team via the MenuList in the upper left.
Note: The scrolling features of both the MenuList and the Dropdown List both scroll in the same direction as the mouse. The scroll direction is like when you are in a webpage and you have clicked on the scrollbar on the righthand side of your internet browser.

The moment you select a team, the dropdown list will automatically open with a list of games that the team you selected has participated in. Selecting a game will display a splash screen. Also, if you had previously already clicked the pause button, it will turn off the pause and automatically start playing the event.

On the splash screen, the two logos of the teams playing will be animated moving towards the center of the basketball court, waiting, then moving outwards from the basketball court.

Note: The left side of the court (and the left side of the VS splash screen) is the Home Team. the right side of the court is the Visitor Team

When the splash screen disappears, you will notice that there are three "clocks" displayed above the basketball court. The clock on the left, displayed in red text, is the shot clock. The clock in the center, displayed with yellow text, is the game clock. The clock on the right, displayed with green text, is the period/quarter of the basketball game in which the event is in.

Underneath the dropdown list, there is now a small icon of the teams playing. This makes it easier to see which teams are currently competing.

Each player object is color coded according to their team colors. These colors were obtained via one of the resources listed above.

There is also a statistic displayed in the bottom right side saying who has possession of the ball. The possession is calculated by the closest person to the basketball, so it is not entirely accurate during passes and when shooting the basketball into the hoop. However, it is accurate enough for general use purposes.

As the animations of the basketball players play out, there are a few things you can do:
* Select a player by clicking on their particular circle
* Move the slider to go to a particular time in the event
* Press the Pause button
* Press the Next Event button
* Select another team on the MenuList which will then bring down the dropdown list again with a new set of games corresponding to the new team selected

Selecting a player will highlight their circle with a transparent circle around them, display their picture in the left sidebar along with their Jersey number, name, and position. A few statistics will show up under the basketball court as well (Total distance traveled, average speed, distance from the ball). The existing statistic of ball possession will still be displayed, but it will be greyed out to draw focus towards the player statistics instead. You can deselect a player by selecting the highlighted circle again. Only one player can be selected at a time.

Note: The player pictures are taken from a URL on the web, so you need internet in order to display their pictures

The slider is attached to the moments. The slider will automatically progress as the event animates. When clicking on the slider, the moments will stop incrementing and you can drag the slider to whatever moment you would like.

The Pause button will pause the animation. This is useful to select players sometimes, since it might be difficult to select a player while they are moving.

The next event button will move on to the next event inside of the game.

Reasoning
---------
I fulfilled the requirements of the assignment and the reasoning is as follows:

1. This was fulfilled because you can select an event via the dropdown list and animate it on the basketball court

2. This was fulfilled by displaying the ball possession statistic. You can further see other information about the event by clicking on the players and displaying their statistics as well. Also, you can see which teams are playing in the event via the splash screen as well as the smaller sized icons underneath the dropdown list

3. This was fulfilled by the slider on the bottom of the screen, allowing you to move your animations and statistics to a particular point of time

4. This was fulfilled by selecting a player. This will display their image, name, jersey number, and position. This also calculates and displays other statistics as well such as their average speed and distance from the ball.


I chose the MenuList to select the teams because I wanted a way to select which event to play based on the team. The MenuList was the easiest way to accomplish this because it held an image and text fields for the team's name, abbreviation, and team ID. After this, the dropdown list would appear. I had chosen a dropdown list because that is the easiest way to display the games, considering how many of them there are. It would not be very feasable to display them in an unscrollable manner. The basketball court was drawn manually by looking at the dimensions of a basketball court and scaling them to turn them into pixel sizes. I used ellipses to display the characters because an ellipse contains a stroke and a fill. Thus, I was able to have the players be two colors to represent their team colors.

Conclusions
===========

Insights
--------
Some insights that cannot be gleamed from the dataset alone without further calculation:
* Total distance traveled per player over the course of an event
* Average speed of a player over the course of an event
* Player distance from the basketball at each moment of an event
* Who is in possession of the ball

Something interesting that I discovered was that some of the events seemed to be duplicates. The conclusion I came up for this was that the NBA game statistics are based off a video recording, and the duplicates were from when they were doing playbacks of a particular event in a game.

Extra Credit
------------
* Potentially for the design of the visualization