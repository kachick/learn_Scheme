$VERBOSE = true


module MicroSchemeR

  PRIMITIVE_FUNCTIONS = {
    :+ => ->x, y{x + y},
    :- => ->x, y{x - y},
    :* => ->x, y{x * y},
    :/ => ->x, y{x / y}
  }.freeze

  class << self

    def _eval(exp)
      if list?(exp)
        list = exp
        fun = _eval(car(list))
        args = _eval_list(cdr(list))
        apply(fun, args)
      else
        if immediate_value?(exp)
          exp
        else
          primitive_function(exp)
        end
      end
    end

    private

    def list?(exp)
      exp.instance_of? Array
    end

    def primitive_function(exp)
      PRIMITIVE_FUNCTIONS.fetch exp
    end

    def car(list)
      list.first
    end

    def cdr(list)
      list.drop 1
    end

    def _eval_list(list)
      list.map{|exp|_eval exp}
    end

    def immediate_value?(exp)
      exp.kind_of? Numeric
    end

    def apply(fun, args)
      fun.call(*args)
    end

  end

end


puts MicroSchemeR._eval([:+, 1, 2])
puts MicroSchemeR._eval([:+, [:+, 1, 2], 3])