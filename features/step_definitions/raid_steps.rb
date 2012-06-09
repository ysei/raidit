Given /^"(.*?)" has scheduled the following raids$/ do |login, table|
  repo = Repository.for(Raid)
  current_user = Repository.for(User).find_by_login(login)

  table.hashes.each do |row|
    r = Raid.new(
      :owner => current_user,
      :where => row[:where],
      :when => Date.parse(row[:when]),
      :start_at => Time.parse(row[:start]),
      :invite_at => Time.parse(row[:start]) - row[:invite_offset].to_i.minutes
    )

    repo.save r
  end
end