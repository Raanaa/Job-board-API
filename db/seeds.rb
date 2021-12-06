
admin=User.new({ username: "admin" , password: 'password' , :admin => true})

if admin.valid?
    admin.save()
elsif admin.errors.any?
    admin.errors.full_messages.each do |msg|
        puts msg
    end
else
    puts "****NOT VALID****"
end