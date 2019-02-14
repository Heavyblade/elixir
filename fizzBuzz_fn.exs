 fizz = fn
   (0,0) -> IO.puts("FizzBuzz")
   (0,_) -> IO.puts("Fizz")
   (_,0) -> IO.puts("Buzz")
 end

 fizz.(0,0)
 fizz.(10,0)
 fizz.(0,10)
