# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

league_a = League.create(name: "Liga MagicSur Enero 2022")
league_b = League.create(name: "South America Magic Series - Command Zone")

league_day_a = LeagueDay.create(league: league_a, day: 1)
league_day_b = LeagueDay.create(league: league_a, day: 2)
league_day_c = LeagueDay.create(league: league_a, day: 3)
league_day_d = LeagueDay.create(league: league_b, day: 1)
league_day_e = LeagueDay.create(league: league_b, day: 2)
league_day_f = LeagueDay.create(league: league_b, day: 3)
league_day_g = LeagueDay.create(league: league_b, day: 4)

table_1 = Table.create(league_day: league_day_a)
table_2 = Table.create(league_day: league_day_b)
table_3 = Table.create(league_day: league_day_c)
table_4 = Table.create(league_day: league_day_d)
table_5 = Table.create(league_day: league_day_e)
table_6 = Table.create(league_day: league_day_f)
table_7 = Table.create(league_day: league_day_g)