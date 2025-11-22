# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# 10.times do |i| 
#   Project.find_or_create_by!(
#     name: "Project #{i + 1}",
#     description: "This is a sample project description for project number #{i + 1}."
#   )
# end

# Create some users for demonstration
unless User.exists?(email: 'admin@example.com')
  admin_user = User.create!(
    email: 'admin@example.com',
    password: 'password123',
    name: 'Admin User'
  )
  puts "Created admin user: #{admin_user.email}"
end

unless User.exists?(email: 'member@example.com')
  member_user = User.create!(
    email: 'member@example.com',
    password: 'password123',
    name: 'Member User'
  )
  puts "Created member user: #{member_user.email}"
end

unless User.exists?(email: 'viewer@example.com')
  viewer_user = User.create!(
    email: 'viewer@example.com',
    password: 'password123',
    name: 'Viewer User'
  )
  puts "Created viewer user: #{viewer_user.email}"
end
