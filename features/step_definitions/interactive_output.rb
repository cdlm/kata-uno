require 'aruba/cucumber'

When(/^I type:$/) do |input|
  input.each_line do |line|
    type(line)
  end
end

Then(/^it should output "(.*?)"$/) do |output|
  actual = unescape(_read_interactive)
  expected = unescape(output)
  expect(actual).to include(expected)
end

Then(/^it should succeed$/) do
  step 'the exit status should be 0'
end
