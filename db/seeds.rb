# db/seeds.rb
puts "Seeding essential fixed data..."

# -----------------------------
# Roles
# -----------------------------
roles = ["business", "staff", "customer", "artist"]
roles.each do |role_name|
  Role.find_or_create_by!(name: role_name)
end
puts "Roles seeded: #{roles.join(', ')}"

# -----------------------------
# Genders
# -----------------------------
genders = ["male", "female", "unisex"]
genders.each do |gender_name|
  Gender.find_or_create_by!(name: gender_name)
end
puts "Genders seeded: #{genders.join(', ')}"

# -----------------------------
# Default admin user
# -----------------------------
admin_email = ENV.fetch("ADMIN_EMAIL")
admin_password = ENV.fetch("ADMIN_PASSWORD")
unless User.exists?(email: admin_email)
  admin_role = Role.find_by(name: "business")
  User.create!(
    username: "Admin",
    email: admin_email,
    password: admin_password,
    password_confirmation: admin_password,
    role: admin_role,
    active: true
  )
  puts "Admin user created: #{admin_email}"
else 
  puts "Admin user already exists: #{admin_email}"
end

puts "✅ Essential seed data completed!"
