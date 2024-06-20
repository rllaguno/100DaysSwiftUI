var videoGamesArray = [String]()
var videoGamesSet = Set<String>()

videoGamesArray.append("Halo")
videoGamesArray.append("Elden Ring")
videoGamesArray.append("Legend of Zelda")
videoGamesArray.append("Hollow Knight")
videoGamesArray.append("Star Wars Battlefront")
videoGamesArray.append("Mario Kart")
videoGamesArray.append("Legend of Zelda")

videoGamesSet = Set(videoGamesArray)

print("Number of items: \(videoGamesArray.count)")
print("Number of unique items: \(videoGamesSet.count)")
