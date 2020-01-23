require 'tempfile'

require 'zeitwerk'
require 'fast_xs'
loader = Zeitwerk::Loader.for_gem
loader.setup

module SimpleXlsx
end

loader.eager_load
