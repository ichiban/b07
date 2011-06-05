class Occurrence < ActiveRecord::Base
  def self.put one, two, three
    self.create do |o|
      o.one = one
      o.two = two
      o.three = three
    end
  end

  def self.get one, two
    Occurrence.where(:one => one, :two => two).order('random()').first
  end  
end
