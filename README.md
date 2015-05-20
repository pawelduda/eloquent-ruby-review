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
