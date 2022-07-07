require_relative './recipe.rb'
class RecipeRepository
  def all
    sql = 'SELECT * FROM recipes;'
    param = []
    result_set = DatabaseConnection.exec_params(sql, param)
    recipes = []
    result_set.each do |record|
      recipe = Recipe.new
      recipe.id = record['id']
      recipe.title = record['title']
      recipe.cooking_time = record['cooking_time']
      recipe.rating = record['rating']
      recipes << recipe
    end
  return recipes
  end

  def find(rating)
    sql = 'SELECT * FROM recipes WHERE rating = $1;'
    param = [rating]
    result_set = DatabaseConnection.exec_params(sql, param)
    record = result_set[0]
    
      recipe = Recipe.new
      recipe.id = record['id']
      recipe.title = record['title']
      recipe.cooking_time = record['cooking_time']
      recipe.rating = record['rating']
      
  return recipe
  end
end