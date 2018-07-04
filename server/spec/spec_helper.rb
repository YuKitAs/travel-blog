# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.expect_with(:rspec) do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with(:rspec) do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec::Matchers.define :be_uuid do
  match do |actual|
    return /[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}/ =~ actual.to_s
  end

  failure_message do |actual|
    return "expected that '#{actual}' to be a UUID"
  end
end

def login
  allow(AuthenticationService).to receive(:authenticate) {}
end
