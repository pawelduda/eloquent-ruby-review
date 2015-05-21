class Foo
  public
  def public_test(other = nil)
    puts 'public ' << self.inspect
    protected_test(other)
    private_test(other)
  end

  protected
  def protected_test(other = nil)
    puts 'protected ' << self.inspect

    if other
      begin
        other.protected_test
      rescue NoMethodError
        puts 'Error: Attempted to call protected method of another instance of the same class (or its subclass).'
        return
      end

      puts 'Called protected method of another instance of the same class (or its subclass).'
    end
  end

  private
  def private_test(other = nil)
    puts 'private ' << self.inspect
    
    if other
      begin
        other.private_test
      rescue NoMethodError
        puts 'Error: Attempted to call private method of another instance of the same class (or its subclass).'
        return
      end

      puts 'Called private method of another instance of the same class (or its subclass).'
    end
  end
end

class Bar < Foo
end

foo1 = Foo.new
foo2 = Foo.new
foo1.public_test(foo2)

bar1 = Bar.new
bar2 = Bar.new
bar1.public_test(bar2)

# Output:
#
# public #<Foo:0x007fec1119f528>
# protected #<Foo:0x007fec1119f528>
# protected #<Foo:0x007fec1119f500>
# Called protected method of another instance of the same class (or its subclass).
# private #<Foo:0x007fec1119f528>
# Error: Attempted to call private method of another instance of the same class (or its subclass).
# public #<Bar:0x007fec1119f0f0>
# protected #<Bar:0x007fec1119f0f0>
# protected #<Bar:0x007fec1119f0c8>
# Called protected method of another instance of the same class (or its subclass).
# private #<Bar:0x007fec1119f0f0>
# Error: Attempted to call private method of another instance of the same class (or its subclass).
