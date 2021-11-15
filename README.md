# Case-Study-1-Google-Cert

*Please refer to this Readme until my Github Page is up*

Bike Case Study Outline
Firm: Cyclistic
Location: Chicago
Director: Moreno
Position: Junior Data Analyst
Department: Marketing Analyst Team
Business Task: 
How do annual members and casual riders use Cyclistic bikes diﬀerently?

Intro:
	For this study I will be analyzing data from Cyclystic, a pseudo firm based in Chicago.  We use a publicly updated data set from Divvy - Motivate international Inc.  The purpose of this study is to provide solutions to maximize the number of annual memberships by identifying ways to increase the number of paid subscription members.

Problems:
	For this study we used data provided from Divvy bikes rides over a one-year period.  I chose to use the most up to date monthly data at the time from August 2020 – September 2021.  The first problem I had to address was the data itself and deciding how to analyze it.  For this case study I decided to use R with its wide array of packages and ease of use.
	My file directory is broken down between the different steps of the data analysis process.  The preparation phase mainly involves importing the data and binding it.  For the process step, I clean the data.  This involves creating new columns, formatting dates, and converting numeric ride data.
	In the analysis phase, I create several graphs and tables below to provide insight into user patterns.  I did drop NA values for data that does not have station names.  Of that 50/50 are roughly member and causal, and most of the bikes were electric.

There are several limitations to the data and pre-cleaned items to be noted:
-There is no credit information or GPS data, making it hard to identify duplicate accounts and rides   
-If bikes are incorrectly docked at a station, the trip time may still run
-The data does not account for trips less than 60 seconds
-The servicing time for bicycles is not included
-Employee rides are not tracked
-Docked bicycles are considered bikes that can be returned to another station, usually they are classic 
-There is only one year of data
-There is no information on docking stations, and capacity

Solutions:
	I propose three solutions involving locations, assets, and services.  The below 6 charts were created in R taking into regard color blind friendly palettes.
The two charts below show the top 5 and bottom 5 stations by bike type for both memberships.  Streeter Dr and Grand Ave are by far the most trafficked start and stop location followed by Michigan Ave & Oak St, Clark St & Elm St, Theater on the Lake, and Millennium Park.  Interestingly, all the top spots except for Clark St & Elm St are located at parks.  Increasing the number of docking stations at these spots might increase the number of memberships.  Another suggestion would be to have member only lockers at some locations.

Pease refer to graphics Start Station Ride Count and End Station Ride Count
	The information on average rides times holds some interesting trends.  Casual members spend double the time biking each day of the week and by month.  Since we only have one year of data and memberships are for some length of time, memberships are more consistent.   One suggestion I could make based on this data is to have lighter framed bicycles offered to members, with more speeds to cater to the casual user experience.

Please refer to graphics Average Ride Duration by Day of Week, Average Ride Duration by Month, and their respective graphs split by bike type.
	Casual riders ride more on weekends than members, while members ride more during the week. Casual riders also are most active during the summer months.  There are two gaps in data for classic bikes and electric bikes.  Classic bikes are not in use during the fall this year.  From spring to end of summer there is no member usage of docked bikes.  I believe having services that cater to an outdoor setting can be useful during warmer seasons.  Some idea to consider would be hosting cycling events like or races, or classes on biking.

Please refer to graphics Ride Count by Week and Ride Count by Month

Conclusion:
	To maximize membership requires understanding users and their needs.  Two thirds of riders are casual.  The bicycle industry is changing quickly with competition from electric scooters.  Cyclistic can stand out as a quality service not just for commuters but also for leisure riders, by expanding docking station capacity, updating their fleet of bikes for leisure use, providing engaging activities, and engaging in thoughtful community awareness. This will increase the membership base beyond a commuter base and understand the needs of our casual user base.

Data:
https://divvy-tripdata.s3.amazonaws.com/index.html
