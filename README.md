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
