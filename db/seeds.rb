User.create(username: "testuser",
  password: "password",
  first_name: "Test",
  last_name: "User",
  skill_level: 2)

Song.create(name: "Someone Like You",
  artist: "Adele",
  difficulty: 5,
  link: "https://www.youtube.com/embed/xzAQe2rwahg",
  created_by: 1)

Song.create(name: "The Ultracheese",
  artist: "Arctic Monkeys",
  difficulty: 6,
  link: "https://www.youtube.com/embed/27P1GzCGfGw",
  created_by: 1)

Song.create(name: "Fly Me To The Moon",
  artist: "Frank Sinatra",
  difficulty: 4,
  link: "https://www.youtube.com/embed/Iq7Q09FIKS0",
  created_by: 1)

  Song.create(name: "Gravity",
    artist: "John Mayer",
    difficulty: 6,
    created_by: 1)
