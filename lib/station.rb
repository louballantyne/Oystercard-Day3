#require 'oystercard'

class Station

  attr_reader :name, :zone, :station_zone

  @@station_zone = { }

  def initialize(name, zone)
    @name = name
    @zone = zone
    store_station(name, zone)
  end

  private

  def store_station(name, zone)
    @@station_zone[name] = zone
  end
end