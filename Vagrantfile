require 'json'
require 'yaml'

VAGRANTFILE_API_VERSION = "2"
confDir = $confDir ||= File.expand_path("~/.fourstead")

foursteadYamlPath = confDir + "/Fourstead.yaml"
foursteadJsonPath = confDir + "/Fourstead.json"
afterScriptPath = confDir + "/after.sh"
aliasesPath = confDir + "/aliases"

require File.expand_path(File.dirname(__FILE__) + '/scripts/fourstead.rb')

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    if File.exists? aliasesPath then
        config.vm.provision "file", source: aliasesPath, destination: "~/.bash_aliases"
    end

    if File.exists? foursteadYamlPath then
        Fourstead.configure(config, YAML::load(File.read(foursteadYamlPath)))
    elsif File.exists? foursteadJsonPath then
        Fourstead.configure(config, JSON.parse(File.read(foursteadJsonPath)))
    end

    if File.exists? afterScriptPath then
        config.vm.provision "shell", path: afterScriptPath
    end
end
