# PostgreSQL-court-reservation-system-design
Course project of Database systems

##Here is the description and requirement of this court reservation system.

Racquetball league 

"The Racqueteers" has a large number of members who play each other in league games. 
- The league has access to a number of courts that any member can reserve up to 7 days prior to a game. 
- Reservations can only be made for one hour at a time, on the hour. 
- Reservations can be canceled any time prior to the game by the member that made the reservation. 
- Reservations must be confirmed on the computer at the reception desk, close to the start of the game (i.e., anywhere from 20 minutes before until 10 minutes after the hour). 
- Each reservation that is neither confirmed or canceled is dropped. (Hence a court becomes available to other players 10 minutes past the hour.) 
- Each dropped reservation results in a penalty point for the member that made the reservation. 
- Penalty points reduce the lead time for making reservations, one day per point. (Hence, a member who has 2 penalty points can make reservations no more than 5 days prior to a game instead of 7 days. Closer to a planned game date, there will be fewer courts and timeslots available.) 
- Each penalty point is pardoned exactly 6 weeks after it was incurred.
