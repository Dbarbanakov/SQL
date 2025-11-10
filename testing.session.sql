-- @block
CREATE TABLE Users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    bio TEXT,
    country VARCHAR(2)
);
-- @block
INSERT INTO Users (email, bio, country)
VALUES (
        'hello@world.com',
        'everything is working as intended',
        'WL'
    ) -- @block
INSERT INTO Users (email, bio, country)
VALUES ('hello@.com', 'foo', 'SP'),
    ('hey@.com', 'bar', 'BR'),
    ('hai@.com', 'baz', 'EU');
-- @block
SELECT *
FROM Users;
-- @block
SELECT email,
    id
FROM Users
WHERE country = 'SP'
    AND id > 1
ORDER BY id ASC
LIMIT 2;
-- @block
CREATE INDEX email_index on Users(email);
-- @block
CREATE TABLE Rooms(
    id INT AUTO_INCREMENT,
    street VARCHAR(255),
    owner_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (owner_id) REFERENCES Users(id)
);
-- @block
INSERT INTO Rooms(owner_id, street)
VALUES (1, 'sailboat'),
    (1, 'cottage'),
    (1, 'cabin'),
    (1, 'farm');
-- @block
SELECT *
FROM Users
    INNER JOIN Rooms on Rooms.owner_id = Users.id;
-- @block
SELECT Users.id AS user_id,
    Rooms.id AS room_id,
    email,
    street
FROM Users
    LEFT JOIN Rooms on Rooms.owner_id = Users.id;
-- @block
CREATE TABLE Bookings(
    id INT AUTO_INCREMENT,
    guest_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in DATETIME,
    PRIMARY KEY (id),
    FOREIGN KEY (guest_id) REFERENCES Users(id),
    FOREIGN KEY (room_id) REFERENCES Rooms(id)
);
-- @block
SELECT guest_id,
    street,
    check_in
FROM Bookings
    INNER JOIN Rooms ON Rooms.owner_id = guest_id
WHERE guest_id = 2;