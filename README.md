# eloquent-ruby-review

## Chapter 1
A good wrap-up for the general coding style, even though I already knew most of it. "Good code is like a good joke, it needs no explanations." :)

## Chapter 2
I knew most of it, except for the fact that I keep on forgetting about the ||= operator.  
I totally forgot about the %w{foo bar} == ['foo', 'bar'] notation too, very nice to know that.

## Chapter 3
It's nice to know about the *XmlSimple* gem. Also a nice reminder about Ruby's *Set* class.

## Chapter 4
One more paragraph about strings being mutable in Ruby decreases the chance of me falling into that trap again.  
I learned that the chomp method strips at most one newline char instead of deleting all of them.

## Chapter 5
I knew most of the regex basics but I had no idea that /^$/ and /\A\z/ are two different things.  
^, $ - cover beginning and end of a **line**
\A, \z - cover beginning and end of a **string**  
It's very important to keep that in mind while working with multiline strings.

## Chapter 6
I learned that there can be only one instance of the same symbol and that makes any otherwise costly comparison or presence checks lightning fast. Use strings only if you need them to store some data to be processed later, otherwise use symbols.

## Chapter 7
Private vs protected:   
*Private* methods can be accessed from a instance of a class and all of its subclasses.
This **WON'T WORK** if the method is private:   
```
def compareTo(x)
  self.someMethod <=> x.someMethod   
end   
```
That's when *protected* comes in: it allows a method of a class to be called not just on its own instance but also on any other instances.

A program was added to examples.

## Chapter 8
So far the best explaination to the whole idea of duck typing I've read.
- Don't couple classes, do not do unnecessary checks for type of an object. Write self-explanatory code and tests instead.
- "If the method is there, it is the right object"
- Use full words while naming variables or methods rather, than abbrevations.

## Chapter 9
A nice introduction both to Test::Unit and RSpec. Some other testing gems such as *shoulda* or *mocha* were mentioned.
Write the damn tests!
I took a random program I wrote before and made some RSpec tests for it. Although the syntax in the book is outdated, the overall setup and first run went smoothly.

## Chapter 10
To make good classes in Ruby, one must know the good balance between writing methods small enough so that they do one single thing and not overdoing this by cluttering classes with code that does not need its own method.    Decomposing classes into small methods provides more options for writing tests later on. The method names should give the maintainer idea about what the method does.

## Chapter 11
Think of most Ruby operators as of regular methods:
```
# Both are the same thing
a + b
a.+(b)
```
While sometimes it's a nice idea to overload operators, it may also confuse readers. A solution to that is to provide an alternative which is a method with a regular name that simply tells what it does.
```
Time.now + 60
Time.now.add_seconds(60)
```

## Chapter 12
There are 4 equality operators in Ruby:   
== - the 'generic' equality operator, it's behaviour is mostly class-specific    
=== - used in case constructs
eql? - returns true if both objects refer to the same hash key, related to class hash method    
equal? - checks if two objects are identical, should not be overriden   

!!!!! In the end, I found this chapter the most confusing up to this point. Leaving a mark for myself to get back to it later in a few days.

## Chapter 13
When we add singleton methods to an object, then the singleton class* is created between the instance and Object class which the instance inherits.

```
special_array = []

class << special_array
  def special_method
    'foo'
  end
end
```

* It is always there but remains hidden until we add some singleton methods to an object.   

The most common use case for singleton methods are class methods (singleton methods defined on instances of Class):
```
class Foo
  def self.foo
    puts 'this is a class method'
  end
end
```

## Chapter 14
Use class variables (@@var) with caution!!! They can mess up your code if you use them within complex classes with several levels of inheritance. It is because of how Ruby resolves (or sets) the value of class variables.   

If we request a class variable that is not defined in a certain class, Ruby will start searching for it in inherited classes, going one level up at a time. If we load several modules to our program which inherit from the same class, the default values for class variables can vary depending on the order the classes get loaded and in such case, finding out where the problem lies can be very time consuming task.   

The workaround for this is to use instance variables on the Class itself:
```
class Foo
  @bar = :buzz

  def self.bar=(b)
    @bar = b
  end

  def self.bar
    @bar
  end
end

Foo.bar # :buzz
```

Better syntax that does the same thing:
```
class Foo
  @bar = :buzz

  class << self
    attr_accessor :bar
  end
end
```

## Chapter 15
Use modules:   
- to create reusable sets of methods that aren't really suitable for a class but can extend one,   
- to avoid name collisions.   
   
Modules can be nested but 3-4 levels are acceptable at most.   
   
Modules are regular objects.

## Chapter 16
include adds module as regular methods:
```
module Bar
  def test
    puts 'I am a method from Bar module'
  end
end

class Foo
  include Bar
end

Foo.new.test
```

extend adds module as singleton class methods:
```
class Foo
  extend Bar
end

Foo.test

# This is same as:
class Foo
  class << self
    include Bar
  end
end
```

When we include module to a class, it becomes its superclass (it goes between the class and nearest superclass).   
When we include one more module, it pushes the first module one level up and takes its place.

## Chapter 17
Not much of the new things for me. I have worked a lot with blocks at such level and feel confident enough to say that I know the very basics.
Just a reminder that providing the each method for any class allows to superpower it with the Enumerable module.

## Chapter 18
The execute around technique is very useful when we need to run some dynamic code in between some other code, like opening/closing the database connection. A good everyday example is the File class:

```
File.open(ARGV[0]).do |f|
  # Do something with the file
end
```

## Chapter 19
There's a mistake in the book on the page 233.
The author mentions block_supplied? method instead of block_given? and such method does not exist.

Implicit blocks:
```
def Foo
  yield if block_given?
end
```

Explicit blocks:

```
# Block arguments must be last in the argument list, even after args with splat operators.

def Foo(&bar)
  bar.call if bar
end
```

Storing blocks in variables:
```
# using Proc object
test_block = Proc.new { puts 'test' }

# using lambda
test_block = lambda { puts 'test' }
```

Using Proc is dangerous because it will silently ignore missing/extra arguments given to the block which can make debuggining harder. lambda.call will raise an exception in such case. 

When using return/break/next inside Proc vs lambda:
- Used inside Proc will cause Ruby to return not just from the block but from the method wrapping the block.
- Used inside lambda will cause Ruby to return only from the block.

## TODO: Add chapters 20, 21, 22

## Chapter 23
In Ruby we can build so-called "magic methods" because of the fact that it method_missing takes name of the method and it's arguments, like this:
```
def method_missing(name, *args)
end
```
Instead of building dozens of methods like this:
```
def replace_name(new_value)
end

def replace_address(new_value)
end

def replace_age(new_value)
end

(many more methods like this)
```
...we can utilize method_missing to avoid code repetition and to make our API more flexible:
```
def replace_param(param_name, new_value)
end

def method_missing(name, *args)
  name_parts = name.split('_')
  replace_param(name[0], args[0])
end
```

## Chapter 24
In Ruby body of a class can be reopened and changed at any time to suit our needs. This is called "monkey-patching".
```
class Foo
  def who_am_i?
    puts 'I am Foo'
  end
end

Foo.new.who_am_i? # I am Foo

class Foo
  def who_am_i?
    puts 'I am Bar'
  end
end

Foo.new.who_am_i? # I am Bar
```

## Chapter 25
Classes in Ruby can contain any code that will be evaluated when the class is created. This adds a lot of flexibility:
```
class Foo
  if RUBY_VERSION == '1.9.3'
    def Bar
    end
  else
    def Bar
    end
  end
end
```
There is a lot of space for mistakes when monkey-patching or putting programming logic inside classes. Automated tests are a must!

## Chapter 26
The most important thing I've learnt from this chapter are:
- class_eval
- module_eval
- instance_eval
They execute string we pass to them as a Ruby code. In context of current class instance, class or module. Using this we can for example add new methods with dynamically generated names.

## Chapter 27
Ruby is a great language when it comes to building both internal and external DSL's. This chapter covers the first. 
DSL is a tool which makes completing tasks for a specified domain much easier. RSpec is a great example of an internal DSL:
```
describe Foo
  it 'should output 5 when 5 is passed to its contructor'
    foo = Foo.new(5)
    foo.to_s.should == '5'
  end
end
```
While DSL's look like a very elegant and clean way to solve problems, one's main focus should be forgotten to spending too much time on coding something that may not be required in the end. It's a common pitfall that can drive someone away from his primary goal.

Pros of building an internal DSL is that despite inventing new 'syntax' we still are able to help ourselves with all of the Ruby language. Unfortunately there are some limitations to what we can do with our DSL but that's when external DSL's come in.

## Chapter 28
To create an external DSL we need to build our own parser in Ruby. We may start with using regular expressions built into Ruby but as things get complex, the regexes may become very hard to read and maintain. Treetop exists to make this job easier. It's a DSL made for creating DSL's ;)
```
foo.tt:

grammar Foo
  rule statement
    add/update/delete
  end
  
  rule argument
    (!"'" . )*
  end
end

# Run "tt foo.tt" to create a .rb class Foo which will parse input according to the rules above
```
Before starting with building an external DSL, ask yourself whether you really need one. Sometimes it could be "przerost formy nad treścią".

## Chapter 29
skipped

## Chapter 30
There are various Ruby implementations, it's nice to know about MRI, YARV, jRuby and Rubinius. Since the book is 4-5 years old, I took that info with grain of salt because I guess a lot of information could be outdated.
