SOLID
## CHAPTER 1

Writing a complex application is not a problem at first. The real problem is applying changes to a poorly written code.

-
Single Responsibility 
Open-Closed
Liskov Substitution
Interface Segregation
Dependency Inversion

DRY - Don't Repeat Yourself

LoD - Law of Demeter 

Design Patterns - should be used but like with anything, it should NOT be overused. Design patterns are tools suitable for solving certain kinds of problems. Applying good tools to the wrong problems doesn't help.

Agile - belief that customers cannot determine what they want until they see the software. Software built the Agile way consists of a lot of tiny increments - it is set to evolve and change. Changing the code must be as easy as possible.

Bad practices from start --> technical debt increases --> at some point it has to be paid

---

OOP:
Objects and messages
Object have state & behaviour

When designing object oriented software, do not worry about who is a sender and what objects communicate with eachother, try to focus on the MESSAGES themselves.

## CHAPTER 2

Single Responsibility - a class should only have one task. A good way to check for the Single Responsibility rule it to speak the class role out loud. If what you say doesn't quite agree with the structure of that class, it means that it could be refactored.

Design classes not just so they work - make sure they are prepared for the future changes! You do not know what specific changes will have to be made, so just make sure you have a good starting point for anything.

TRUE
-
Transparent
Reasonable
Usable
Exemplary

MAKE SURE THAT THE CLASS HAS ONE, SINGLE RESPONSIBILITY! LOWER THE AMOUNT OF REASONS THIS SINGLE CLASS MAY HAVE TO CHANGE!

Do not hurry with applying any design patterns until you know exactly which way will the software evolve. Starting with a bad pattern prematurely might cause a lot of rewriting later on.

Hide class variables in methods - this way you can create reusable wrappers where you can put some related code. When that code changes, you will only have to update the wrapper - not every single place where the calculation was done. DRY. 

Do not worry about extra method calls - premature optimization is even worse.

Avoid situations where data structures don't make their purpose obvious. Use Ruby Struct to better describe tiny data structures that do not have any behaviour (and therefore don't really need a separate class).

HIDE DATA FROM YOURSELF

Don't depend on complicated data structures.
Same applies to methods - divide them into ones that have a single responsibility.

## Chapter 3

CBO - coupling between objects - should be as low as possible.
High CBO = harder to test

Avoid hard-coding other classes and dependencies in your classes. Create interfaces for other objects to be injected.

Wrap dependencies inside methods.

When class' initialize method takes many parameters - use options hash as its parameter. Do not do this to small classes, e.g.:

```
class Coordinate
  def initialize(x, y)
    # ommited
  end
end
```

# Dependency direction
Make objects depend on things that change less often than them.

Some classes can potentially change more often - you can tell from their requirements and expectations about what role they need to fulfill.

Concrete classes change more often than abstract ones.
