# BBS4

## About

## Dictionary

### booking

- describes one or more seats that belong to the same group of people
- contains fields:
    - UUID
    - forename
    - surname
    - classname
    - set of seats
    - time of the booking
        - possible values are:
            - afternoon
            - evening
    - price type (how much has to be paid per seat)\
          - differs depending on the time of the booking
    - price for the seats
    - price already paid
    - comments

### active booking

- an active booking is one, that is currently being edited
- there can only exist one active booking at a time

## Project Structure

### bookings screen

- provides an overview of the bookings in graphical format
- seat overview
    - displays the seats with different colors based on their states.
    - valid states are:
        - free (green)
        - booked (yellow)
        - overbooked (purple)
        - paid (red)
        - active (turquoise)
    
### active booking overview
- allows the user to view and edit the active booking
        
