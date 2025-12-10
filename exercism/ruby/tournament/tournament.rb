class Tournament
  def self.tally(input)
    header + team_scores(input)
  end

  def self.header
    <<~HEREDOC
      Team                           | MP |  W |  D |  L |  P
    HEREDOC
  end

  def self.team_scores(input)
    prepped_input = prep_input(input)

    return '' if prepped_input.first.empty?

    team_repo = TeamRepository.new

    update_scores(prepped_input, team_repo)
    calc_teams_points_and_matches_played(team_repo)
    format_scores_output(team_repo)
  end

  def self.calc_teams_points_and_matches_played(team_repo)
    team_repo.teams.each do |team|
      team.matches_played = team.wins + team.losses + team.draws
      team.points = team.wins * 3 + team.draws
    end
  end

  def self.format_scores_output(team_repo)
    score_output = ''

    team_repo.sort_teams_by_score.each do |team|
      devider = ' |'
      score_output << (
        team.name.ljust(30) + devider +
        format('%3d', team.matches_played) + devider +
        format('%3d', team.wins) + devider +
        format('%3d', team.draws) + devider +
        format('%3d', team.losses) + devider +
        format('%3d', team.points) + "\n"
      )
    end

    score_output
  end

  def self.update_scores(prepped_input, team_repo)
    prepped_input.each do |line|
      team_1 = team_repo.find_or_create_team(line[0])
      team_2 = team_repo.find_or_create_team(line[1])
      result = line[2]

      case result
      when 'win'
        team_1.wins += 1
        team_2.losses += 1
      when 'loss'
        team_1.losses += 1
        team_2.wins += 1
      when 'draw'
        team_1.draws += 1
        team_2.draws += 1
      end
    end
  end

  def self.prep_input(input)
    input.lines.map do |line|
      team_1, team_2, result = line.strip.split(';')
    end
  end
end

class Team
  attr_reader :name

  attr_accessor :matches_played, :wins, :draws, :losses, :points

  def initialize(name)
    @name = name
    @matches_played = 0
    @wins = 0
    @draws = 0
    @losses = 0
    @points = 0
  end
end

class TeamRepository
  attr_accessor :teams

  def initialize
    @teams = []
  end

  def find_or_create_team(name)
    team = teams.find { |team| team.name == name }
    unless team
      team = Team.new(name)
      teams << team
    end
    team
  end

  def sort_teams_by_score
    teams.sort do |team_1, team_2|
      if team_1.points > team_2.points
        1
      elsif team_1.points < team_2.points
        -1
      elsif team_1.points == team_2.points
        team_2.name <=> team_1.name
      end
    end.reverse
  end
end
