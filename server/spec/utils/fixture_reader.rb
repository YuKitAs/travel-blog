require 'json'

FIXTURE_BASE_PATH = '../client/test/fixture'.freeze

def read_json(file)
  return JSON.parse(File.read(get_fixture(file)))
end

def get_fixture(file)
  return File.join(FIXTURE_BASE_PATH, file)
end
