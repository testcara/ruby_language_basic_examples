# Here just one simple example to check the expection
begin
  puts "Out of the raise"
  begin
    puts "In the raise"
    puts "before raise"
    raise 'hello world'
    puts "after raise"
  end
  puts "Out the raise again"
  puts "I am running out of raise"
rescue
  puts "catch the raise"
end
