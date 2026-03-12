CREATE TABLE `users`(
        `id` INT UNSIGNED AUTO_INCREMENT,
        `username` VARCHAR(50) UNIQUE NOT NULL,
        `first_name` VARCHAR(32) NOT NULL,
        `last_name` VARChAR(32) NOT NULL,
        `password` VARCHAR(128) NOT NULL,
        PRIMARY KEY (`id`)
);

CREATE TABLE `schools`(
      `id` INT UNSIGNED AUTO_INCREMENT,
      `name`VARCHAR(100) NOT NULL,
      `type`ENUM('Primary', 'Secondary', 'Higher Education') NOT NULL,
    `location`VARCHAR(100) NOT NULL,
    `founded`Year,
    PRIMARY KEY (`id`)
);

CREATE TABLE `companies` (
     `id` INT UNSIGNED AUTO_INCREMENT,
     `name` VARCHAR (64) NOT NULL ,
     `industry` ENUM(`Education`,`Business`,`Technology`) NOT NULL,
    `location` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE connections (
         user_id INT UNSIGNED NOT NULL,
         connected_user_id INT UNSIGNED NOT NULL,
         PRIMARY KEY (user_id, connected_user_id),
         FOREIGN KEY (user_id) REFERENCES users(id),
         FOREIGN KEY (connected_user_id) REFERENCES users(id)
);
