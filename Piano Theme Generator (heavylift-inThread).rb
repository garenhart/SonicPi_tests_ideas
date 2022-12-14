# Piano Theme Generator

# Generator drivers
use_random_seed 4137001          # Random seed changes everything
use_bpm 90                       # Set your bpm to taste
use_synth :piano

PATTERN_REPEAT_CHANCE = 0.2     # Chance of a rhythm division repeating within the rhythm
REST_CHANCE = 0.2               # Chance of a rest being selected in a melody
ROOT = :g5
MODE = :locrian


# Creates notes and durations given a scale, beats, units and the largest beat.
# Return array is an array of note, duration pairs
define :melodyPatternMaker do |myScale, beats, units, largestBeat|
  pattern = make_rhythm_pattern(beats, units, largestBeat)
  melody = create_melody(myScale, pattern.length)
  return melody.zip(pattern)
end

# Pattern division constants
# 4     whole note
# 3     dotted half note
# 2     half note
# 1.5   dotted quarter note
# 1     quarter note
# 0.75  dotted eight note
# 0.5   eight note
# 0.375 dotted sixteenth note
# 0.25  sixteenth note
ALL_PATTERN_BEAT_DIVISIONS = [4, 3, 2, 1.5, 1, 0.75, 0.5, 0.375, 0.25]

# Returns a random beat pattern less than or equal to the time division passed in
define :pickRandomPatternLessThanEqualTo do |lessThanTime|
  
  chosenDuration = ALL_PATTERN_BEAT_DIVISIONS.choose
  if chosenDuration > lessThanTime
    chosenDuration = lessThanTime
  end
  
  return chosenDuration
  
end

# Function that makes a rhythm pattern of various durations
# Beats define the number of beats in the pattern
# Unit defines the unit of beat (just like a time signature)
# Low limit defines the lower limit of the beat division to be used - pass 1 for quarter notes and so on...
define :make_rhythm_pattern do |beats, unit, low_limit|
  
  # Empty result for the
  result = []
  
  # The total time in beats we need to fill
  total_time = 4 * beats / unit
  
  # Select the first duration
  #chosenDuration = ALL_PATTERN_BEAT_DIVISIONS.choose
  chosenDuration = pickRandomPatternLessThanEqualTo(low_limit)
  result.push chosenDuration
  total_time -= chosenDuration
  
  # While we have time left
  while total_time > 0
    
    # If we have enough remaining time to cover the same chosen duration
    if total_time >= chosenDuration && rand() < PATTERN_REPEAT_CHANCE
      result.push chosenDuration
      total_time -= chosenDuration
    else
      chosenDuration = pickRandomPatternLessThanEqualTo([total_time, low_limit].min)
      result.push chosenDuration
      total_time -= chosenDuration
    end # end chosenDuration if
  end # end while
  
  # Return the resultant array of durations
  return result
  
end #end function

# Creates a random melody from a scale of length
define :create_melody do |theScale, length|
  myNotes = []
  for i in 0...length
    if rand() < REST_CHANCE
      myNotes.push :r
    else
      myNotes.push theScale.choose
    end
  end
  return myNotes
end

define :playPattern do |pattern|
  for i in 0...pattern.length
    play pattern[i][0], sustain: pattern[i][1]
    sleep pattern[i][1]
  end
end

# Click for reference
live_loop :click do
  loop do
    sample :perc_snap
    sleep 1
    3.times do
      sample :perc_snap2, amp: 0.25
      sleep 1
    end
  end
end


# High piano does a 4 bar pattern
live_loop :pianoHigh do
  highPiano8 = melodyPatternMaker(scale(ROOT, MODE, num_octaves: 1.5), 16, 4, 4)
  puts "High Piano" + highPiano8.to_s
  with_fx :reverb, room: 0.8 do
    loop do
      playPattern(highPiano8)
    end
  end
end

# Lower piano does a 2 bar pattern
live_loop :pianoLow do
  lowPiano4 = melodyPatternMaker(scale(ROOT - 24, MODE, num_octaves: 1.5), 8, 4, 4)
  puts "Low Piano" + lowPiano4.to_s
  with_fx :reverb do
    loop do
      playPattern(lowPiano4)
    end
  end
end