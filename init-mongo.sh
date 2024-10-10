#!/bin/bash
set -ebux

# Wait for MongoDB to start
until mongosh --eval "print(\"waited for connection\")"; do
  sleep 2
done

# Create the database and a dummy collection
mongosh <<EOF
use ${DB_NAME};

# Create a new user with read and write access
db.createUser({
  user: "${DB_USERNAME}",
  pwd: "${DB_USER_PASSWORD}",
  roles: [
    { role: "readWrite", db: "${DB_NAME}" }
  ]
});

# Create a dummy collection and insert a document
db.dummyCollection.insert({
  name: "Sample Document",
  description: "This is a dummy document for testing purposes.",
  createdAt: new Date()
});
EOF

echo "Database, user, and dummy collection created successfully."