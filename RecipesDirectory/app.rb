# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/recipe_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipes_directory')

# Perform a SQL query on the database and get the result set.
sql = 'SELECT id, title, cooking_time, rating FROM recipes;'
result = DatabaseConnection.exec_params(sql, [])
recipes = RecipeRepository.new
# Print out each record from the result set .
recipes.all.each do |recipe|
  puts "#{recipe.id}. #{recipe.title} - Cooking time: #{recipe.cooking_time} minutes - Rating: #{recipe.rating}"
end