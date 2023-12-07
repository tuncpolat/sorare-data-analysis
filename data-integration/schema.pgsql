-- Database: dbproject-sorare

/* 
-- kill all connections to the database
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'dbproject-sorare' -- ← change this to your DB
  AND pid <> pg_backend_pid(); 
*/

DROP TABLE IF EXISTS Statistics;
DROP TABLE IF EXISTS playsIn;
DROP TABLE IF EXISTS Season;
DROP TABLE IF EXISTS OwnershipHistory;
DROP TABLE IF EXISTS NFT;
DROP TABLE IF EXISTS Card;
DROP TABLE IF EXISTS Player;

CREATE TABLE Season (
    seasonID INTEGER PRIMARY KEY,
    seasonYear INTEGER,
    startDate DATE, -- date data type available?
    endDate DATE,  -- date data type available?
    leagueName VARCHAR(50),
    leagueType VARCHAR(50),
    leagueCountry VARCHAR(50)
);

CREATE TABLE Player (
    playerID INTEGER UNIQUE,
    firstname VARCHAR(50),
    lastname VARCHAR(50), 
    birthDate DATE, -- date data type available?
    heightCm INTEGER, --clean up
    weightKg INTEGER, --clean up
    nationality VARCHAR(50),
    PRIMARY KEY (firstname, lastname, birthDate) 
);

CREATE TABLE Statistics (
    playerID INTEGER,
    seasonID INTEGER,
    teamID INTEGER,
    teamName VARCHAR(50), 
    gamesAppearances INTEGER, 
    gamesLineups INTEGER,
    gamesMinutes INTEGER, 
    gamesPosition VARCHAR(50), 
    gamesCaptain BOOLEAN, 
    gamesRating FLOAT, -- clean up
    goalsTotal INTEGER, 
    goalsConceded INTEGER, 
    goalsAssists INTEGER, 
    goalsSaved INTEGER, 
    tacklesTotal INTEGER, 
    tacklesBlocks INTEGER,
    tacklesInterceptions INTEGER, 
    foulsDrawn INTEGER, 
    foulsCommited INTEGER, 
    passesKey INTEGER, 
    passesTotal INTEGER,
    passesAccuracy INTEGER, 
    duelsWon INTEGER, 
    duelsTotal INTEGER, 
    cardRed INTEGER, 
    cardYellow INTEGER, 
    cardYellowred INTEGER,
    shotsTotal INTEGER, 
    shotsOn INTEGER, 
    dribblesAttempts INTEGER, 
    dribblesSuccess INTEGER, 
    dribblesPast INTEGER,
    penaltyWon INTEGER, 
    penaltyCommited INTEGER, 
    penaltyScored INTEGER, 
    penaltyMissed INTEGER, 
    penaltySaved INTEGER,
    substituesIn INTEGER, 
    substitutesOut INTEGER, 
    substitutesBench INTEGER,
    PRIMARY KEY (playerID, seasonID, teamID),
    FOREIGN KEY (playerID) REFERENCES Player(playerID)
);

CREATE TABLE playsIn (
    playerID INTEGER,
    seasonID INTEGER,
    PRIMARY KEY (playerID, seasonID),
    FOREIGN KEY (playerID) REFERENCES Player(playerID),
    FOREIGN KEY (seasonID) REFERENCES Season(seasonID)
);

CREATE TABLE Card (
    assetID TEXT PRIMARY KEY,
    rarity VARCHAR(50),
    seasonYear INTEGER,
    birthDate DATE NOT NULL, -- Date Data Type
    bestFoot VARCHAR(50),
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    shirtNumber INTEGER,
    FOREIGN KEY (firstName, lastName, birthDate) REFERENCES Player (firstName, lastName, birthDate)
);

CREATE TABLE NFT (
    nftID TEXT PRIMARY KEY, -- "id"
    assetID TEXT, -- "assetId"
    slug TEXT,
    currentOwnerAddress TEXT,
    FOREIGN KEY (assetID) REFERENCES Card(assetID)
);

CREATE TABLE OwnershipHistory (
    address TEXT,
    transferDate timestamp, -- "from" / DATETIME
    -- priceWei INTEGER, -- too big
    priceEuro FLOAT,
    transferType VARCHAR(50),
    blockchain VARCHAR(50),
    nftID TEXT,
    PRIMARY KEY(address, transferDate),
    FOREIGN KEY (nftID) REFERENCES NFT(nftID)
);