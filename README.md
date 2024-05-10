# BBS4 - Gaia

## About

This application is used to organize and visualize the bookings of the seats of the [Concert Hall](https://www.konzertkirche-nb.de/) in Neubrandenburg. This includes visualizing which seats are free, taken, booked more than once and whether they are already paid for. It also helps with more easily keeping track of the amounts of money paid per booking and offers useful statistics about the entirety of the bookings.\

## Name

BBS4 stands for Benefiz-Buchungs-System 4. This roughly translates to beneficiary-bookings-system 4. The name stems from the fact, that it is mainly used by the Albert-Einstein-Gymnasium in Neubrandenburg to organize their yearly beneficiary concerts. Also, it is the 4th iteration I have done of this kind of system (See also: History).\
Its codename is Gaia. This is the first 'proper' application I have produced that is a) usable and b) being used. So, like Gaia it came before everything else.

## History

### Version 1 - Google Sheets (2021)

On one fateful day, I was sitting in a train going home after visiting a school excursion. Next to me sat a supervising teacher and she just happened to mention what a chore it was to handle the bookings of the upcoming beneficiary concert by hand. And then she kind of hypothetically asked, if we could do something about that. So, I started thinking (purposefully avoiding building a _real_ graphical application, because I felt it was too complicated for this kind of problem). Version 1 is what I came up with.\
\
Version 1 was the epitome of "if its stupid and it works its not stupid". It worked purely on Google Sheets functions and had many of the features it still has today. For every cell, that belonged to the seat plan of the concert hall, I would take its name (i.e. B3). This would painstakingly converted into a row and a seat number (row 2 seat 3 in this case). By coordinating a pattern which all bookings had to follow (in our case it was "R3 P2") you could scan the document for any matches. If any cell matched the calculated value, you knew, that someone booked the cell. However, it could also handle paying and double-bookings. Paying was rather easy, simply take the first occurance of your seat-string and go to the right into the specified column. If there was something in there, it was paid. Otherwise, it was not. Double-bookings means, that two distinct people tried booking the same seat. So, instead of checking for a match with your seat-string, you count the number of matches. This gives you two values: the number of bookings assigned to that seat and whether it was paid or not.\
\
The end goal is to have a single number, based on which you could use conditional formatting to colour the cells. Then, the users could enter the seats which were booked and the whether they were paid and the cells of the corresponding seats would colour themselves automatically. (You could also input names, classes or the spreadsheet would automatically calculate the price the booker had to pay, but those are little things without much relevance).\
The system I came up with was the following: take the number of bookings per seat and multiply it by two. Then, add whether the seat is paid for or not. This gives you a unique number for each state of seat like so:\
\
0  - seat is free\
1  - seat is not booked, but paid? this state is impossible\
2  - seat is booked once, but not paid yet\
3  - seat is booked once, and paid\
4+ - seat is booked more than once. we do not care about whether it is paid or not, the ambiguity has to be removed first\

### Version 2 - Google Apps Script (2022)

TODO

### Version 3 - WPF (2023)

TODO
