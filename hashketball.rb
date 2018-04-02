# Write your code here!
require 'pry'

def game_hash
    {
        home: {
          team_name: "Brooklyn Nets",
          colors: ["Black", "White"],
          players: {
            "Alan Anderson" => {
              number: 0,
              shoe: 16,
              points: 22,
              rebounds: 12,
              assists: 12,
              steals: 3,
              blocks: 1,
              slam_dunks: 1
            },
            "Reggie Evans" => {
              number: 30,
              shoe: 14,
              points: 12,
              rebounds: 12,
              assists: 12,
              steals: 12,
              blocks: 12,
              slam_dunks: 7
            },
            "Brook Lopez" => {
              number: 11,
              shoe: 17,
              points: 17,
              rebounds: 19,
              assists: 10,
              steals: 3,
              blocks: 1,
              slam_dunks: 15
            },
            "Mason Plumlee" => {
              number: 1,
              shoe: 19,
              points: 26,
              rebounds: 12,
              assists: 6,
              steals: 3,
              blocks: 8,
              slam_dunks: 5
            },
            "Jason Terry" => {
              number: 31,
              shoe: 15,
              points: 19,
              rebounds: 2,
              assists: 2,
              steals: 4,
              blocks: 11,
              slam_dunks: 1
            }
          }
        },
        away: {
          team_name: "Charlotte Hornets",
          colors: ["Turquoise", "Purple"],
          players: {
            "Jeff Adrien" => {
              number: 4,
              shoe: 18,
              points: 10,
              rebounds: 1,
              assists: 1,
              steals: 2,
              blocks: 7,
              slam_dunks: 2
            },
            "Bismak Biyombo" => {
              number: 0,
              shoe: 16,
              points: 12,
              rebounds: 4,
              assists: 7,
              steals: 7,
              blocks: 15,
              slam_dunks: 10
            },
            "DeSagna Diop" => {
              number: 2,
              shoe: 14,
              points: 24,
              rebounds: 12,
              assists: 12,
              steals: 4,
              blocks: 5,
              slam_dunks: 5
            },
            "Ben Gordon" => {
              number: 8,
              shoe: 15,
              points: 33,
              rebounds: 3,
              assists: 2,
              steals: 1,
              blocks: 1,
              slam_dunks: 0
            },
            "Brendan Haywood" => {
              number: 33,
              shoe: 15,
              points: 6,
              rebounds: 12,
              assists: 12,
              steals: 22,
              blocks: 5,
              slam_dunks: 12
            }
          }
        }
    }
end

def all_players
    game_hash[:home][:players].merge(game_hash[:away][:players])
#looks like {"AA"=>{..},"RE"=>{..},"BL"=>{..}}
end

def num_points_scored(name)
    all_players[name][:points]
end

def shoe_size(name)
    all_players[name][:shoe]
end

def team_colors(team)
    game_hash.each do |location, team_data|
        team_data.each do |attribute, data|
            if data == team
                return team_data[:colors]
            end
        end
    end 
end

def total_dunks
    total_dunks = 0

    all_players.each do |name, data_points|
        total_dunks += data_points[:slam_dunks]
    end

    total_dunks
end

def team_names
    teams = []
    game_hash.each do |location, team_data|
        teams.push(team_data[:team_name])
    end

    return teams
end

def player_numbers(team)
    team_jerseys = []
    game_hash.each do |location, team_data|
        if team_data[:team_name] == team
            team_data[:players].each do |name, stats|
                team_jerseys.push(stats[:number])
            end
        end
    end

    return team_jerseys
end

def player_stats(name)
    all_players[name]
end

def big_shoe_rebounds
    name = most_player(:shoe)[0]
    all_players[name][:rebounds]
end

#BONUS 
def most_player(statistic) #based on the stat/category argument, returns name and value of the person with the highest stat)
    most = {}
    all_players.each do |name, data|
        data.each do |stat, value|
            if stat == statistic
                most[name] = value
            end
        end
    end
    most.sort_by {|name, stat| stat}.last
end

def most_points_scored
    most_player(:points)[0]
end

def winning_team
    home_points = 0
    away_points = 0

    game_hash.each do |location, data_hash|
        data_hash[:players].each do |names, stats|
            if location == :home
                home_points += stats[:points]
            else away_points += stats[:points]
            end
        end
    end

    if home_points > away_points
        return game_hash[:home][:team_name]
    else return game_hash[:away][:team_name]
    end
end

def player_with_longest_name
    most = []
    all_players.each do |name, data|
        most.push(name)
    end
    most.sort_by {|name| name.length}.last
end

# #SUPER BONUS
def long_name_steals_a_ton?
    player_with_longest_name == most_player(:steals)[0]
end



# module HashDigAndCollect
#     def dig_and_collect *keys
#       keys = keys.dup
  
#       next_key = keys.shift
#       return [] unless self.has_key? next_key
  
#       next_val = self[next_key]
#       return [next_val] if keys.empty?
  
#       return next_val.dig_and_collect(*keys) if next_val.is_a? Hash
  
#       return [] unless next_val.is_a? Array
#       next_val.each_with_object([]) do |v, result|
#         inner = v.dig_and_collect(*keys)
#         result.concat inner
#       end
#     end
#   end
  
#   class Hash
#     include HashDigAndCollect
#   end