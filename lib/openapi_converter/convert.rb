require "yaml"
require "pry"

module OpenapiConverter
  class Convert
    def execute
      file_path = "examples/v2.0/member.yml"
      yaml = YAML.load_file(file_path)

      new_yaml = {}
      # swagger required
      if yaml["swagger"] == "2.0"
        new_yaml["openapi"] = "3.0.0"
      end

      # info required
      new_yaml["info"] = yaml["info"]

      # paths
      path = yaml['paths'].keys[0]
      new_yaml["paths"] = {
        path => yaml['paths'][path]
      }

      # components
      new_yaml['components'] = { "schemas" => yaml['definitions'] }

      YAML.dump(new_yaml, File.open("examples/v3.0/convert_member.yml", "w"))
    end
  end
end
