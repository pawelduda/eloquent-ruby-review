## Chapter 1

Writing a complex application is not a problem at first. The real problem is applying changes to a poorly written code.

SOLID
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

## Chapter 2

Single Responsibility - a class should only have one task. A good way to check for the Single Responsibility rule it to speak the class role out loud. If what you say doesn't quite agree with the structure of that class, it means that it could be refactored.

Design classes not just so they work - make sure they are prepared for the future changes! You do not know what specific changes will have to be made, so just make sure you have a good starting point for anything.

### TRUE
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

### Dependency direction
Make objects depend on things that change less often than them.

Some classes can potentially change more often - you can tell from their requirements and expectations about what role they need to fulfill.

Concrete classes change more often than abstract ones.

## Chapter 4
Keep the public interface of a class simple, while hiding whatever you can from other classes.

Objects should trust other objects to do their job, when asking for something instead of telling them, how to behave (just like in a good boss-employee relation).

### Law of Demeter

Objects should be loosely coupled.

Only talk to your immediate neighbors or "only use one dot".

```
# Somewhere inside a method:
customer.bicycle.wheel.tire # BAD!
customer.ride # BETTER!

hash.keys.sort.join(',') # OK
```

Third example is not really a violation of the Law of Demeter because there are only 2 types involved in this "train wreck":

```
enum --> enum --> enum --> string
```

## Chapter 5

Do not depend on classes and their names - depend on their behaviour.

Polymorphism - ability of many different objects to respond to the same messages. Senders of such messages do not care about a class of the receiver - they simply trust them to do their jobs, which is implementing their own specific version of a desired behaviour.

Polymorphism can be achieved in two ways:
- by duck typing,
- by class inheritance and modules.

POLYMORPHIC METHODS ARE INTERCHANGABLE FROM THE SENDER'S POINT OF VIEW!!!

Following code can be replaced by duck-typed:
- case...when <class>
- kind_of?, is_a?
- responds_to?

Don't be fooled by respond_to?(specific_method): it doesn't seem to directly depend on a class but it is same as 2 first cases in a disguise - it still depends on a specific method that a class would implement!

trusting objects > conttolling objects

Duck typing might make the code less obvious because it doesn't rely on any concrete class. In this case documentation and tests are very useful.

The only case where depending on a concrete classes is acceptable is, when an objects talks to a Ruby base class or any other dependencies that can be considered very stable and aren't subject to change in a meaningful period of time. Also, Ruby classes aren't easy to override - it can be achieved by monkey patching but it can be very dangerous when done wrong.

## Chapter 6

Do not force subclasses to know, how to interact with their superclasses - it places a burden on a programmer, who creates new subclasses to remember about calling super inside initialize method, to know about what messages the superclass sends, etc.

To avoid that trouble, use a post_initialize method in the superclass, as a hook. Have subclasses override that method, which makes the super call disappear.

```
class Bicycle
  def spares
    {
      tire_size: tire_size,
      chain: chain
    }.merge(super) # BAD! Use line below instead!
    }.merge(local_spares) # GOOD!
  end
end

class RoadBike < Bicycle
  def local_spares
    { tape_color: tape_color }
  end
end
```

The above refactoring removes the programmer's need to remember about superclass-specific behaviour when implementing its new subclass.

## Chapter 7
There is a tendency for modules to end with -able, e.g. "comparable", "enumerable". It suggest that a part of class can be put inside a reusable module when it plays some role. This is a good strating point for creating a new duck type, in this case, a module.

Module can have own constants and methods that can be overridden by classes extended by such modules. Modules are similar to class inheritance.

Method lookup without modules: 
```
# RoadBike --> Bicycle --> Object
```

Method lookup with modules:
```
class Bicycle
  include Schedulable
end

# RoadBike --> Bicycle --> Schedulable --> Object
```

```
# Object --> Singleton class --> Superclass --> Superclass' modules --> (repeat) --> Object
```

If a class depends on its variable that decides, what message should an object send to itself, according to its type, this can be refactored using classical inheritance.

If object answeing to a message sent by receiver needs to lookup who the receiver is (check its class), that's a red light that there is a duck type because some objects have a similar interface. If they also happen to share behaviour, extract and put it inside a module.

Superclass and module should only have code that applies to ALL of their subclasses!!!

### LSP - Liskov Substitution Principle
Type system must be SUBSTUITABLE to its supersystems.

super = additional dependency, avoid it if you can. Use hook methods instead.

CREATE SHALLOW CLASS/MODULE HIERARCHIES!!!

## Chapter 8
Composition: 
Bicycle has-a Parts.
Bicycle is composed of Parts.
1 next to class in UML - 1 Parts object per Bicycle
1..* - Parts has one or more Part

OpenStruct takes hash as a parameter and derives attributes from it.

Aggregation - a special case of composition, where an object has life independent of its container. If the container is gone, the object continues to exist. Example:
university - department : composition
department - proffesors : aggregation

Inheritance vs composition:
- inhertitance has free message delegation,
- inheritance requires objects to be codified in a class hierarchy

- composition requires explicit delegation,
- objects can have a more independent structure - the relationship is not codified in the class hierarchy

If inheritance cannot be defined explicitly, use composition as a solution.

Inheritance is only better when it provides high rewards for a low risk. "Inheritance is a specialization."
