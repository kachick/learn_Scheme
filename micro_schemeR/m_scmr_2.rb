$VERBOSE = true


module MicroSchemeR

  PRIMITIVE_FUNCTIONS = {
    :+ => [:prim, ->x, y{x + y}],
    :- => [:prim, ->x, y{x - y}],
    :* => [:prim, ->x, y{x * y}],
    :/ => [:prim, ->x, y{x / y}]
  }.freeze

  GLOBAL_ENV = [
    PRIMITIVE_FUNCTIONS
  ]

  class << self

    def _eval(exp, env)
      if list?(exp)
        list = exp
        if special_form? list
          eval_special_form list, env
        else
          fun = _eval(car(list), env)
          args = _eval_list(cdr(list), env)
          apply(fun, args)
        end
      else
        if immediate_value?(exp)
          exp
        else
          value_for exp, env
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

    def _eval_list(list, env)
      list.map{|exp|_eval exp, env}
    end

    def immediate_value?(exp)
      exp.kind_of? Numeric
    end

    def apply(exp, args)
      if primitive_function?(exp)
        exp[1].call(*args)
      else
        lambda_apply exp, args
      end
    end

    def primitive_function?(exp)
      exp[0] == :prim
    end

    # env: Hash
    # envs: Array<Hash>
    def value_for(var, envs)
      if env = envs.find{|h|h.key? var}
        env[var]
      else
        raise NameError, "could not find the variable: #{var}"
      end
    end

    def extended_env(parameters, args, envs)
      current_env = Hash[parameters.zip(args)]
      [current_env, *envs]
    end

    def eval_let(exp, env)
      parameters, args, body = *let_to_parameters_args_body
      new_exp = [[:lambda, parameters, body]]
      _eval new_exp, env
    end

    def let_to_parameters_args_body(exp)
      [exp[1].map{|e|[0]}, exp[1].map{|e|e[1]}, exp[2]]
    end

    def closure(exp, env)
      parameters, body = exp[1], exp[2]
      [:closure, parameters, body, env]
    end

    alias_method :eval_lambda, :closure

    def lambda_apply(closure, args)
      parameters, body, env = *closure_to_parameters_body_env(closure)
      new_env = extended_env parameters, args, env
      _eval body, new_env
    end

    def closure_to_parameters_body_env(closure)
      closure.drop 1
    end

    def special_form?(exp)
      lambda?(exp) || let?(exp)
    end

    def lambda?(list)
      list[0] == :lambda
    end

    def let?(list)
      list[0] == :let
    end

    def eval_special_form(list, env)
      case
      when lambda?(list)
        eval_lambda list, env
      when let?(list)
        eval_let list, env
      else
        raise 'should not reach here'
      end
    end

  end

end


#puts MicroSchemeR._eval([:+, 1, 2])
#puts MicroSchemeR._eval([:+, [:+, 1, 2], 3])

exp = [[:lambda, [:x, :y], [:+, :x, :y]],
              3, 2]
puts MicroSchemeR._eval(exp, MicroSchemeR::GLOBAL_ENV)