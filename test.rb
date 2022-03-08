require 'yaml'
class Person
  def initialize(name, age, gender)
    @age = age
    @gender = gender
    @name = name
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
    self.new(data[:name], data[:gender], data[:age])
  end
end

Person.from_yaml("---\n:name: Bilguundalai\n:age: 20\n:gender: M\n")

