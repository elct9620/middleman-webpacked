module MiddlemanWebpacked
  class CommandRunner
    class << self
      AVAILABLE_MODE = %i[production development none]

      def bin(path = nil)
        return @bin if path.nil?
        @bin = path
      end

      def mode(new_mode = nil)
        return @mode if new_mode.nil?
        @mode = new_mode if AVAILABLE_MODE.include?(new_mode)
      end

      def satisfy?
        return false if bin.nil?
        File.exist?(bin)
      end
    end

    attr_reader :app, :options, :mode

    def initialize(app, options)
      @app = app
      @options = options
      @arguments = []

      setup
    end

    def setup
      raise NotImplementedError, "The command didn't setup for execute"
    end

    def loaders
      @loaders.map do |type, loader|
        "--module-bind #{type}=#{loader}-loader"
      end
    end

    def entries
      options.entry.map do |name, path|
        "--entry #{name}=./src/#{path}"
      end
    end

    def command
      [
        self.class.bin,
        "--mode #{self.class.mode}"
      ]
        .concat(entries)
        .concat(@arguments)
        .join(' ')
    end
  end
end
