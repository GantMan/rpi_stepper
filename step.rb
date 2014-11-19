require 'pi_piper'
include PiPiper

#GPIO Board Pins are 35, 36, 37, 38
bcm_pins = [19, 16, 26, 20]
@stepper_pins = []

@seq = [ [1,0,0,0],
        [1,1,0,0],
        [0,1,0,0],
        [0,1,1,0],
        [0,0,1,0],
        [0,0,1,0],
        [0,0,1,1],
        [1,0,0,1]]

# Set output pins
bcm_pins.each do |p|
  @stepper_pins.unshift(PiPiper::Pin.new(:pin => p, :direction => :out))
end

def spin(steps, sleep_time)
  steps.times do
    8.times do |halfstep|
      4.times do |pin|
        @stepper_pins[pin].update_value(@seq[halfstep][pin])
      end
      sleep(sleep_time)
    end
  end
end

spin(512, 0.001)

# turn it off when we're done
@stepper_pins.each do |pin|
  pin.off
end