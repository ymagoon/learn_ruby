require 'json'
require 'yaml'

class A
  def initialize(string, number)
    @string = string
    @number = number
  end

  def to_s
    "In A:\n   #{@string}, #{@number}\n"
  end

  def to_json(*a)
    {
      "json_class" => self.class.name,
      "data"       => {"string" => @string, "number" => @number}
    }.to_json(*a)
  end

  def self.json_create(o)
    new(o["data"]["string"], o["data"]["number"])
  end
end

#a = A.new("Im a test string",5)
#puts a.to_s
#json_string = a.to_json
#puts json_string
#puts JSON.parse(json_string)

class Person
  attr_accessor :name, :age, :gender

  def initialize(name, age, gender)
    @name = name
    @age = age
    @gender = gender
  end

  def to_yaml
    YAML.dump ({
      :name => @name,
      :age => @age,
      :gender => @gender
      })
  end

  def self.from_yaml(string)
    data = YAML.load string
    p data
    self.new(data[:name], data[:age], data[:gender])
  end

  def to_json
    JSON.dump ({
      :name => @name,
      :age => @age,
      :gender => @gender
      })
  end

  def self.from_json(string)
    data = JSON.load string
    self.new(data['name'], data['age'], data['gender'])
  end
end

p = Person.new("David",28,"male")
#puts p.to_yaml
puts p.to_json
p = Person.from_json(p.to_json)
puts p.name
puts p.age
puts p.gender
#p = Person.from_yaml(p.to_yaml)
#puts "Name #{p.name}"
#puts "Age #{p.age}"
#puts "Gender #{p.gender}"
