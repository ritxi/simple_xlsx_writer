module SimpleXlsx
  module XsRefine
    refine String do
      alias_method :to_xs, :fast_xs
    end
  end
end
