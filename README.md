# FIFA-Teams-Database
A comprehensive relational database system designed to manage and maintain data for FIFA teams, matches, players, stadiums, and groups. 

# Features

**Eight Interconnected Tables**: 
- Designed using SQL on phpMyAdmin.
- Established relationships through primary and foreign keys to ensure seamless data integration.

**Data Population**:
- Populated the database using a combination of SQL scripts and manual entry.
- Ensures robust data handling and flexibility for modifications.

**Advanced SQL Query Execution**:
- Enables efficient querying, updating, and optimization of data.
- Maintains normalization and data integrity for accurate and seamless operations.

# Database Scheme

The database consists of the following tables:

**Teams**:
- Stores details about teams, including team_id, team_name, and group_id.

**Matches**:
- Tracks match details such as match_id, home_team_id, away_team_id, home_score, and away_score.

**Players**:
- Contains player-specific information like player_id, player_name, team_id, and position.

**Groups**:
- Maintains group details with fields like group_id and group_name.

**Stadiums**:
- Stores data on stadiums, including stadium_id, stadium_name, and location.

**MatchDetails**:
- Logs additional details for matches, such as attendance or referee information.

**vMatchDetails (View)**:
- Combines data from multiple tables to provide a comprehensive view of match details.

**vMatchesTeams (View)**:
- Offers an aggregated view of matches and their respective teams for streamlined analysis.


# Entity Relationships
Primary and foreign keys are used to establish robust relationships between the tables.

Example: team_id in the Teams table links to the Matches and Players tables for team-specific data.
