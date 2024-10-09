#!/bin/bash

# Wait for MongoDB to start
until mongosh --eval "print(\"Waiting for connections\")" >/dev/null 2>&1; do
    echo "Waiting for MongoDB to start..."
    sleep 5
done

echo "MongoDB is up and running!"

# Authenticate as root or create the root user
mongosh -- "
    db = db.getSiblingDB('admin');
    if (!db.auth('$MONGO_INITDB_ROOT_USERNAME', '$MONGO_INITDB_ROOT_PASSWORD')) {
        print('Root user not found. Creating root user...');
        db.createUser({
            user: '$MONGO_INITDB_ROOT_USERNAME',
            pwd: '$MONGO_INITDB_ROOT_PASSWORD',
            roles: [{ role: 'root', db: 'admin' }]
        });
        print('Root user created successfully.');
    } else {
        print('Root user exists, skipping creation.');
    }

    // Create the application user
    db = db.getSiblingDB('$DB_NAME');
    db.createUser({
        user: '$DB_USERNAME',
        pwd: '$DB_USER_PASSWORD',
        roles: [{ role: 'readWrite', db: '$DB_NAME' }]
    });
    print('Application user created successfully.');
"