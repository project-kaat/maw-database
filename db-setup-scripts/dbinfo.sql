DROP DATABASE maw;
CREATE DATABASE maw;
USE maw;

---Create the main network storage table

CREATE TABLE network (
    bssid VARCHAR(16) NOT NULL,
    channel SMALLINT,
    wps BOOLEAN NOT NULL DEFAULT FALSE,
    last_time_seen TIMESTAMP NULL,
    roaming BOOLEAN NOT NULL DEFAULT FALSE,
    cracked BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY(bssid)
);

---Create the auxiliary tables

CREATE TABLE essid (
    id INT NOT NULL AUTO_INCREMENT,
    value VARCHAR(32) NOT NULL,
    bssid VARCHAR(16) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (bssid) REFERENCES network(bssid) ON DELETE CASCADE
);

CREATE TABLE location (
    id INT NOT NULL AUTO_INCREMENT,
    bssid VARCHAR(16) NOT NULL,
    value VARCHAR(64) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (bssid) REFERENCES network(bssid) ON DELETE CASCADE
);

CREATE TABLE pmkid (
    bssid VARCHAR(16) NOT NULL,
    value VARCHAR(256) NOT NULL,
    PRIMARY KEY (bssid),
    FOREIGN KEY (bssid) REFERENCES network(bssid) ON DELETE CASCADE
);

CREATE TABLE messagepair (
    id INT NOT NULL AUTO_INCREMENT,
    value VARCHAR(512) NOT NULL,
    bssid VARCHAR(16) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (bssid) REFERENCES network(bssid) ON DELETE CASCADE
);

CREATE TABLE security (
    id INT NOT NULL AUTO_INCREMENT,
    value VARCHAR(64) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE password (
    bssid VARCHAR(16) NOT NULL,
    value VARCHAR(32) NOT NULL,
    PRIMARY KEY (bssid),
    FOREIGN KEY (bssid) REFERENCES network(bssid) ON DELETE CASCADE
);

---Create value link tables

CREATE TABLE security_network_link (
    security_id INT NOT NULL,
    bssid VARCHAR(16) NOT NULL,
    PRIMARY KEY (security_id, bssid),
    FOREIGN KEY (security_id) REFERENCES security(id),
    FOREIGN KEY (bssid) REFERENCES network(bssid) ON DELETE CASCADE
);
