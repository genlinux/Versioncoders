a=Entry.create([{:title=>'first text',:body=>'body for first text'}]) do |u|
u.user_id=4
end
10.times do |i|
Entry.create([{:title=>'second text',:body=>'body for second text',:user_id=>4}])
end
