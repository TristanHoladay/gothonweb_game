class Room

  def initialize(name, description)
    @name = name
    @description = description
    @paths = {}
    @quips = ["The Gothon scares you so bad that you crap your pants!\n Then you try to change your pants with the clean pair in your backpack,\n but then you trip while taking off your slippery poop pants and you fall and hit your head!\n You fade into peaceful oblivion.\n Unfortunately, the Gothon's live stream their victory to theirs and yours home planets and everyone sees a close-up of your naked poopy butt cheecks.",
    "Wow you died. No surprise there!", "How about you eat some win berries and try this again loser!", "You're parents are so proud....Not!! Ha, gets them every time."]
  end

  # these make it easy for you to access the variables
  attr_reader :name
  attr_reader :paths
  attr_reader :description

  def go(direction)
    return @paths[direction]
  end

  def add_paths(paths)
    @paths.update(paths)
  end

  def quips
    @q = @quips[rand(0..(@quips.length-1))]
    puts "#{@q}"
  end

end


generic_death = Room.new("death", "trying").quips
