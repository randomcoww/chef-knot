module KnotHelper
  CONFIG_PATH ||= '/etc/knot/knot.conf'

  class ConfigGenerator

    def self.generate_from_hash(c)
      ## config is very yaml like but --- separator does not work
      c.to_hash.to_yaml.lines.drop(1).join('')
    end
  end
end
