// creates initial admin user with root access

db.createUser(
    {
      user: "qadmin",
      pwd: "to_boldly_go",
      roles: [
         { role: "root", db: "admin" }
      ]
    }
,
    {
        w: "majority",
        wtimeout: 5000
    }
);
db.createCollection("test");