#Ex 1
class Baby
  def initialize #anytime an object is called on Baby is born, do THIS code.
    self.cry #implicit (don't say it literally) receiver, vs. explicit (you say it literally). 
    #Can do things explicitly or implicitly. This is called explicitly. implcit version of self is: 
    #def initialize
      #cry    end
  end

  def cry
    puts "Waa!"
  end
end

#EX 2
class Integer
  def seven? #Instance Method 
    #checks if current method is 7
    self == 7
  end
end
#Goal: 8.seven? - 8 is the object (receiver), seven? is the message to the 8 (messenger)
#9.seven? - 9 is a specific instance of something called an Integer. 
#An instance refers to itself, with self. 
#Hence, why self == 7 above is used to check if the passed in Integer is actually 7.



#EX 3:
#anything that starts with a lower case letter that isn't a keyword MUST be: 
#a variable, or a method
class Baby
  def initialize #instance method
    hello #When Ruby sees this, it thinks it's a local var, then looks for a method
  end
end

class String
  def hello
    "Hello"
  end
end
#if Baby.new is called right now, it will say NameError: undefined local var or method "hello" for Baby.new. 
#It looks for the var or method, and since the method hello is defined in the String class, it calls an error.

#Objects are like people - you can ask them questions, which is really cool.

command = :reverse
string = "Hello"
string.command
#the above three lines won't work. BECAUSE Ruby takes this literally. It doesn't get 
string."#{command}"
#conceptually right, but since command is an OBJECT it doesn't work. SO, to make it work, use send.
string.send(command)
#send method is a metaprogramming method, or dispatcher. Why is it 
string.send("upcase")
#sending a string, "upcase". Way of taking a value that isn't a method, and telling the object to interpret "upcase" as a method call on itself.
#it's a dispatcher - you're dispatching this value as a method call, so that this is equivalent to => string.upcase
commands = gets.strip
downcase
"HELLO".send(commands)
"hello"
#You can ask an object what methods it has, called introspection. 

class Baby
  def initialize #instance method, or hook, callback, or life-cycle
    cry #implicitly being called on self, which is an instance of a baby, and since babies respond to a method called 'cry', this code will work.
  end
end
north_west = Baby.new
#=> "Waa!"

#EX 4:
#var names never mean anything to the program
x = north_west
#new goal in this example: To say x.name and have "North West" print
#Errors are the negative space of my programming - it is telling me what is missing. 
#You don't have to be a super genious to see what to add into the negative space! :)
class Baby
  def name
    "North West" #implicit return value
    "Blue Ivy" #implicit return, and since it's the last line of code, Ruby returns THIS line. 
  end
end
north_west.name #=> "Blue Ivy"
class Baby
  def name
    return "North West" #explicit because of return keyword
  end
end

class Baby
  def name
    the_name 
  end
end
north_west.name = "North West" #syntactic sugar because Ruby allows us to put a space between a method that end sin = to make it look pretty, because...
north_west.name="Argument" #this isn't as pretty.
#Leaving out parentheses makes code look prettier. 
class Baby
  def name=
  end
end
north_west.name = "Test"
#=> Argument Error because it asks for 1 argument, and no argument is given.

#EVERYTHING SO FAR, COMES OUT TO THIS:
class Baby 


  def initialize #Instance Method, Hook
    @fingerprint = rand(1...100)
    cry
  end

  def cry #Instance Method, behavior
    puts "Waa!"
  end

  def name #Instance Method, getter/reader - main purpose is to get a value
    #This is the only place where the_name could hav been definved and valid

    the_name
  end

  def name=(name_argument) #Instance Method, setter/writer = main purpose is to write a value
    the_name = name_argument
  end #Ruby destroys the_name var

  def eye_color
    @eye_color
  end

  def eye_color=(eye_color)
    @eye_color = eye_color #Increases the scope of the variable - CASTING/HOISTING
  end

end

north_west.name = "NORTH WEST"
north_wese.name #=> UNDEFINED LOCAL VARIABLE OR NAME, because the variable (the_name) is in incorrect scope. 
#the_name is local to the variable of the method it's created in. this var gets destroyed
#$global variables - DON'T USE THESE!! THEY'RE WRONG!!! Global vars are for the interpreter to store state about itself. 
#It needs to remember things, and it uses the global name space to do so. 
#If you use the global variable in the above class, it will give ONE copy because it's a global variable. 
#To make a new instance of a baby with a NEW name, we need a different variable...
#We need an INSTANCE Variable. The scope is within the entire instance itself. change the_name to > @the_name - the @ sign is the instance var.
#Way we give obj properties is through instance vars. The way we access those properties is through instance methods.
#Becuase obj only respond to methods, they respond to "internal state".
#type in self to see what scope you're in.
self
#=> main
class Baby
  def scope
    raise self.inspect
  end
end
Baby.new.scope
#=> Instance scope
#When you're inside an instance method, you're programming from within the object itself. 
#When you're use the obj somewhere else, you're outside of the scope.
#When you're programming, you MUST be aware of the scope you're programming in, and never have to guess... 
  #IF YOU DON'T KNOW, USE THE SELF KEYWORD!!!
#IF you can read the var from outside the obj, it is considered public. Otherwise, it is PRIVATE. 
  #@fingerprint in initialize method is a private var.
#syntactic vinegar - opposite of sugar (used to make your code look prettier than it should, like name = arg vs. name=(arg)... 
#Purposely designed methods/vars to be ugly because you're not designed to do it. Vinegar is used for metaprogramming.


#Ex 5

class Dog
  
  #What is the scope of this line of code?
    #I'm in the dog CLASS scope
  raise self.inspect #=> Dog
  def bark 
    #what scope am I in now? 
      #Instance Scope
    puts "Woof!"
  end
end
#Smallest scope possible are variables.
#ORDER OF SCOPES, FROM LARGEST TO SMALLEST:
  #Main (global) scope
    #Class Scope - Need to put babies in this scope, because instances need to be able to write to it, and classes need to be able to expose it.
      #Instance Scope
        #Local Variable Scope
#hoisting is move scopes within a class/program. 
#Moving from smallest (local) to largest (Main), can be accessed. However, other direction is not possible.

#Need to be able to remember every single baby that's born and put it somewhere. 
#In terms of scope, who's job is it to remember this?
  #Class is responsible, not an individual method

class Baby 

  attr_accessor :name, :eye_color #=> self.attr_accessor(:name, :eye_color)
      #this creates instance methods:
        #name, name=
        #eye_color, eye_color=
    #Being called implicitly because there is no receiver. No . , it's implicit.
    #This is a CLASS method. 
  #
  @@all = [] #class variable
  
  def self.all #(OR Baby.all) - this will also work, but self is more flexible, in case class name gets changed.
    #Class Method, class getter / class reader. It reads from a class variable.
    #if I call Baby.all and get an error message displays Baby.class_var_get(:@@all), 
    #it's calling the instnace, instead of the CLASS. 
    #Class methods operate ont he class in general, whereas instance methods operate on each indiv instance.
    #Like execute Order 66 where ALL stormtroopers do something at the same time. SO, north_west.cry makes sense.. north_west.all doesn't make sense.
    @@all
  end

  def initialize
    #I need to save the newly born Baby
    @@all << self
    @fingerprint = rand(1...100)
    cry
  end

  def cry 
    puts "Waa!"
  end
end



#ex 6
#Explaining which attribute accessor/getter/reader to use, and WHEN.
avi = Person.new

avi.name = "Avi"
avi.name #=> "Avi"

avi.formal_name #=> "Mr. Avi"

class Person
  attr_accessor :name

  def formal_name
    puts "Mr. #{self.name}" #name is being called on self. 
  end
end
#What is something I will need to set/get all the time, vs. a behavior?
#Is this a property of the object, or a behavior of the object? 
  #formal_name is not a property, but a behavior on top of the name of the person 
  #name is a property of a person.

#Our goals to learning is to not finish the curriculum as quickly as possible, but to absorb and LEARN the curriculum quickly. 
#You need to read, practice this stuff, and learn it. It's not about quanitity, but truly quality. 