# Database-Project
IBCITC Database Project using SQL

In this project, you will design and implement a database according to the below scenario and requirements. The completed assignment will also be presented in a written report. 

# Case Scenario
IBC International Training Center (IBCITC) is a training organization located in Texas. It is
establishing the most comprehensive learning resource for multiple training programs, such as
Language Program, IT Program, Art Program and the like. Over the past two decades IBCITC has
helped tens of thousands of trainees all around Texas transform their lives through provided trainings
which have a presence across 7 locations (in different areas).

IBCITC continues to recruit overseas instructors with trained pedagogy and experience and offers a
couple of academic programs. It features state-of-the-art learning environments and resources.

IBCITC trusts in your database ability. They hire you as an individual to set up a database system that
helps them to effectively store and manage data regarding their employees, programs, locations, rooms,
technologies, courses, training schedules, and events, etc. After several interviews with the IBCITC,
you have come up with the following notes of business rules, which are all very important to IBCITC:

• IBCITC is a multi-program training center (e.g., Language Program, IT Program, Art Program
and other programs). Program can be identified by ProgramID and has other attributes called
ProgramName, ProgramDescription, and EstablishingTime.

• IBCITC is a multi-location training center. Location can be identified by LocationID and has
other attributes called LocationName, Address and LastMaintainanceTime.

• For each location, IBCITC has more than one room. Room can be identified by LocationID and
RoomNumber. A room can be either a Lab, a Lecture Room, or an Office. If it is an office, it
has an additional attribute called RoomTelephone (e.g., +10481000000). If it is a lab or a lecture
room, it has attributes of Layout and Occupancy.

• Employee has identifier of EmployeeID and has attributes of EmployeeName, Salary, DOB,
and CountryOfOrigin. An employee can be an instructor or an Administrative Staff. Instructor
has an additional attribute called EducationLevel. Administrative staff has attributes called
AdminType, AdminLevel, and Department.

• Timeslot has identifier of TSID and has attributes of DayofWeek, StartTime, and EndTime.

• TrainingCourse has identifier of TrainingCourseID and other attributes of
TrainingCourseName, Description, Training Level (e.g., Intro, Master and Professional Level),
and Price. A Training Course can have one or more sections for a given month. A Training
Course can be provided repeatedly each month. Section has identifier of SectionID, and
attributes of Month, and SectionType (e.g., 4-hour or 2-hour).

• IBCITC uses technological tools (e.g., Oracle, PyCharm, Visio) to facilitate course delivery.
Technological Tools is identified by ToolTypeID and has attribute of Description.

• Events (e.g., Orientation, Networking) are recorded for each training section and have the
identifier of EventID and other attributes of EventName, PlannedBudget, ApprovedBudget and
EventDescription.

# With further briefing, the following business rules are identified.

• IBCITC makes training schedules on a monthly basis. An instructor can be scheduled to lecture
more than one section of a training course in a given month, while a section can only be
scheduled to one and only one instructor in a given month. A lecture room can participate in
many schedules, one schedule, or no schedules; however, given a time slot, a lecture room can
be scheduled for no more than one section. One timeslot can participate in many schedules, one
schedule, or no schedules; one section can be arranged in only one schedule.

• A training course has one and only one coordinator; an administrative staff can be assigned as
the coordinator for zero, one or many training courses.

• An instructor specifies her/his preferred section and time slots. Instructors are trained to use
one, none, or many types of technological tools.

• A room can be either a lecture room, a lab, or an office. A lab can be equipped with more than
one type of technological tool.

• A room can be used by more than one program. A program can use one or more rooms.

• IBCITC keeps a record of events. An administrative staff can be assigned to be in charge of
zero, one or more than one event. An event only has one and only one employee in charge. A
room can be scheduled in zero, one or many events, while an event can use more than one room.

# You have chosen Oracle as an industry standard database platform for the implementation. You have
decided to internally call the system you are working on “IBC IT Solution.” Your client requests that
you create the following sample SQL queries and report the outcomes based on suitable example data
(these are examples of typical queries needed):

1. List the EmployeeID and Salary of all employees.

2. List the EmployeeID, AdminLevel and Salary of all administrative staff.

3. List all instructors who are scheduled to teach courses that have the price over 500$.

4. List the EmployeeID and EmployeeName of all instructors with an Education Level of
Master. Display the Staff name in a single field in the format of: LastName, FirstName and
have the field alias of ‘Emp_FullName’.

5. List all instructors who are trained to use more than one technological tool. For each instructor
in the results, display the EmployeeID and count of technological tools on which the instructor
has been trained.

6. Count the total number of sections scheduled for the Course “Python” in 2024.

7. List all schedules for the year 2024 with the instructor “Jeff Thomas.”
