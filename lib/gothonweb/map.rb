module Map

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
    @quips[rand(0..(@quips.length-1))]
  end

end

CENTRAL_CORRIDOR = Room.new("Central Corridor",
  """
  You crawled your way onto the Gothon ship, to exact vengeance on the Gothons for killing your crew on planet \"Gang Gang\".
  Your Goal?!? To find the Gothon armory and using one of their own neutron bombs eliminate the Gothon crew and ship, yourself escaping in one of their pods.
  What do you have on you?\n Besides your rugged good looks (a weapon depending on the circumstance, am i right?!)\n you have a backpack for storage, an AR-Blaster (shoots laser 5.56 rounds),\n a sweat band to keep your vision clear in dire situations,\n a great sense of humor,\n and a steely-iron will!
  As you quietly move forward, a Gothon comes out of a room, locks it, and when he turns he sees you. What do you do: shoot, run away, or tell a joke?
  """)

GOTHON_FIGHT = Room.new("Gothon Fight",
  """
    You engage the Gothon:
                        Hey Gothon!
                        What you puny sack of meat?
                        Knock Knock...
                        (with great reluctance, producing physical perspiration, the Gothon replies) Who...who's there?
                        I eat mop.
                        I ea..eat mop who? Uh...Ahh, that's revolting!!
                        (You grab your stomach, start laughing, and point at the Gothon with tears streaming down your cheeks)
                        (And like that the Gothon cracks a slight smile, let's out a little chuckle, and then falls dead.)
  You walk towards the green, lumpy, mass. That was a little intense. Now what: step over, or turn back?
  """)

BEDROOM = Room.new("Bedroom",
  """
  You step over your first defeated foe (vengeance feels good, and slippery as you almost slip on the green slime-blood pooling on the deck) and make your way down the central corridor and find a room on your right--the bedroom.
  Ah the bedroom, where the magic happens! You move around looking in drawers and closets, even finding a scrap book, before you head down the hall and duck into the toilet.
  """)

TOILET = Room.new("Toilet",
  """
  Even heros on a mission of vengeance need to use the restroom, so you relieve yourself, find a little gothon hair gel, and now that you're refreshed you head to the armory!
  """)

LASER_WEAPON_ARMORY = Room.new("Laser Weapon Armory",
  """
  You make your way through the armory and find the neutron bomb. You smartly decide not to kick it but instead gingerly place it in your backpack and head for the bridge.
  """)

BRIDGE = Room.new("Bridge",
  """
  You find a Gothon as the helm. He sees you. Thinking quickly you tell another joke\:
        A ham sandwich walks into a bar and orders a beer,\n
        bartender says \"sorry, we don't serve food here.\"
  The Gothon dies a quick but painful death. Now to place the bomb.
  """)

PLACE_BOMB = Room.new("bomb", "You get to work activating the neutron bomb. It takes a few tries but you finally guess the correct 3 digit code. And now you hi-tail it to the escape pods.")

ESCAPE_POD = Room.new("Escape Pods",
  """
  With the clock counting down you have to overcome another feat of wit--a game of rock, paper, scissors--to determine which escape pod is the not broken one.
  """)

ESCAPE_POD_WINNER = Room.new("victory",
  """
  You do it! Your skill doesn't really pay off because it's a game of chance, but you are on your way out of the doomed ship. And as you fly out into space a massive explosion flashes behind you.
  You're so cool you don't even look back, but nod as you place your space shades over your steelly eyes.
  """)

ESCAPE_POD_LOSER = Room.new("The End",
  """
  You ran out of time and couldn't beat the ship at rock, paper, scissors so you innie minnie miny moed your way into a escape pod (so reckless!)
  and as you fly out into space and the Gothon ship explodes behind you, you nod and as you reach to put on your space shades your pod implodes.
  """)

GENERIC_DEATH = Room.new("You Died", "Listen to this:")

CENTRAL_CORRIDOR.add_paths({
    'shoot' => GENERIC_DEATH,
    'dodge' => GENERIC_DEATH,
    'tell a joke' => GOTHON_FIGHT
    })

GOTHON_FIGHT.add_paths({
    'step over gothon' => BEDROOM,
    'turn back' => GENERIC_DEATH
    })

BEDROOM.add_paths({'move on' => TOILET})

TOILET.add_paths({
  'die on the crapper' => GENERIC_DEATH,
  'take gothon hair gel' => LASER_WEAPON_ARMORY
  })

LASER_WEAPON_ARMORY.add_paths({
  'kick the bomb' => GENERIC_DEATH,
  'place bomb in backpack' => BRIDGE
  })

BRIDGE.add_paths({
  'shoot' => GENERIC_DEATH,
  'joke' => PLACE_BOMB
  })

PLACE_BOMB.add_paths({
  '123' => ESCAPE_POD,
  '*' => GENERIC_DEATH
  })

ESCAPE_POD.add_paths({
  'win game' => ESCAPE_POD_WINNER,
  'lose game' => ESCAPE_POD_LOSER
  })

START = CENTRAL_CORRIDOR

# A whitelist of allowed room names. We use this so that
    # bad people on the internet can't access random variables
    # with names.  You can use Test::constants and Kernel.const_get
    # too.

  ROOM_NAMES = {
      'CENTRAL_CORRIDOR' => CENTRAL_CORRIDOR,
      'GOTHON_FIGHT' => GOTHON_FIGHT,
      'BEDROOM' => BEDROOM,
      'TOILET' => TOILET,
      'LASER_WEAPON_ARMORY' => LASER_WEAPON_ARMORY,
      'BRIDGE' => BRIDGE,
      'PLACE_BOMB' => PLACE_BOMB,
      'ESCAPE_POD' => ESCAPE_POD,
      'ESCAPE_POD_WINNER' => ESCAPE_POD_WINNER,
      'ESCAPE_POD_LOSER' => ESCAPE_POD_LOSER,
      'START' => START
      #'GENERIC_DEATH' => GENERIC_DEATH
      }

  def Map::load_room(session)
    # Given a session this will return the right room or nil.
    return ROOM_NAMES[session[:room]]
  end

  def Map::save_room(session, room)
    # Store the room in the session for later, using it's name.
    session[:room] = ROOM_NAMES.key(room)
  end

end
